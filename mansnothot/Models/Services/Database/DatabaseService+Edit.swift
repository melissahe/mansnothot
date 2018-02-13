//
//  DatabaseService+Edit.swift
//  mansnothot
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension DatabaseService {
    /**
     */
    public func editProfileImage(withUserID userID: String, image: UIImage) {
        StorageService.manager.storeUserImage(image: image, withUserID: userID) { (errorMessage, imageURL) in
            if let errorMessage = errorMessage {
                self.delegate?.didFailChangingUserImage?(self, error: errorMessage)
                print("couldn't change user iamge")
            } else if let imageURL = imageURL {
                self.delegate?.didChangeUserImage?(self, toImageURL: imageURL)
                print("changed user image")
            }
        }
    }
    
    /**
     */
    public func editPost(withPostID postID: String, newPost: Post, newImage: UIImage?) {
        let ref = postsRef.child(postID)
        
        ref.updateChildValues(["category": newPost.category,
                      "title": newPost.title,
                      "bodyText": newPost.bodyText ?? ""
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailEditingPost?(self, error: error.localizedDescription)
            } else if let image = newImage {
                StorageService.manager.storePostImage(image: image, withPostID: postID, completion: { (errorMessage, _) in
                    if let errorMessage = errorMessage {
                        self.delegate?.didFailEditingPost?(self, error: errorMessage)
                    } else {
                        self.delegate?.didEditPost?(self, newPost: newPost)
                    }
                })
            } else {
                self.delegate?.didEditPost?(self, newPost: newPost)
            }
        }
    }
    
    /**
     */
    public func editBio(withUserID userID: String, newBio: String?) {
        let ref = usersRef.child(userID).child("bio")
        
        ref.setValue(newBio) { (error, _) in
            if let error = error {
                self.delegate?.didFailChangingBio?(self, error: error.localizedDescription)
                print("couldn't change bio")
            } else {
                self.delegate?.didChangeBio?(self, withText: newBio ?? "")
                print("successfully changed bio")
            }
        }
    }
    
    /**
     */
    //ban users
    public func banUser(withUserID userID: String) {
        let ref = usersRef.child(userID).child("isBanned")
        
        ref.setValue(true) { (error, _) in
            if let error = error {
                self.delegate?.didFailBanning?(self, error: "Could not ban user: \(error.localizedDescription)")
            }
        }
    }
    
    /**
     */
    public func flagUser(withUserID flaggedUserID: String, flaggedByUserID userID: String, flaggedCompletion: @escaping (Bool) -> Void) {
        let ref = usersRef.child(flaggedUserID)
        
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var user = currentData.value as? [String : Any] {
                var flaggedByDict = user["flaggedBy"] as? [String : Any] ?? [:]
                var flags = user["flags"] as? Int ?? 0
                //if the user has flagged before
                if let _ = flaggedByDict[userID] {
                    self.delegate?.didFlagUserAlready?(self, error: "You have flagged this user already.")
                } else { //user has not flagged before
                    flaggedByDict[userID] = true
                    
                    //add flags
                    flags += 1
                    DispatchQueue.main.async {
                        self.delegate?.didFlagUser?(self)
                        flaggedCompletion(true)
                    }
                }
                user["flaggedBy"] = flaggedByDict as Any
                user["flags"] = flags as Any
                
                currentData.value = user
             
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, bool, _) in
            if let error = error {
                //fail to flag
                self.delegate?.didFailFlagging?(self, error: error.localizedDescription)
            }
        })
    }
    
    /**
     */
    public func flagPost(withPostID flaggedPostID: String, flaggedByUserID userID: String, flaggedCompletion: @escaping (Bool) -> Void) {
        let ref = postsRef.child(flaggedPostID)
        
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var post = currentData.value as? [String : Any] {
                
                var flaggedByDict = post["flaggedBy"] as? [String : Any] ?? [:]
                var flags = post["flags"] as? Int ?? 0
                //if user has flagged before
                if let _ = flaggedByDict[userID] {
                    self.delegate?.didFlagPostAlready?(self, error: "You have flagged this post already.")
                } else { //user has not flagged before
                    flaggedByDict[userID] = true
                    flags += 1
                    DispatchQueue.main.async {
                        self.delegate?.didFlagPost?(self)
                        flaggedCompletion(true)
                    }
                }
                
                post["flaggedBy"] = flaggedByDict
                post["flags"] = flags
                
                currentData.value = post
                
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, bool, _) in
            if let error = error {
                self.delegate?.didFailFlagging?(self, error: error.localizedDescription)
            }
        })
    }
    
    //for likes, there should be separate functions!!
    public func likePost(withPostID postID: String, likedByUserID userID: String, likeCompletion: @escaping (Int) -> Void, dislikeCompletion: @escaping (Int) -> Void) {
        let ref = postsRef.child(postID)
        
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var post = currentData.value as? [String : Any] {
                var likesDict = post["likedBy"] as? [String : Any] ?? [:]
                var likes = post["numberOfLikes"] as? Int ?? 0
                var dislikesDict = post["dislikedBy"] as? [String : Any] ?? [:]
                var dislikes = post["numberOfDislikes"] as? Int ?? 0
                
                //if user has liked already
                if let _ = likesDict[userID] {
                    //remove like
                    likes -= 1
                    likesDict.removeValue(forKey: userID)
                    DispatchQueue.main.async {
                        self.delegate?.didUndoLikePost?(self, withPostID: postID)
                        likeCompletion(likes)
                    }
                } else { //if user has not liked yet
                    //add like
                    likes += 1
                    likesDict[userID] = true
                    
                    if let _ = dislikesDict[userID] {
                        dislikes -= 1
                        dislikesDict.removeValue(forKey: userID)
                        DispatchQueue.main.async {
                            self.delegate?.didUndoDislikePost?(self, withPostID: postID)
                            dislikeCompletion(dislikes)
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate?.didLikePost?(self, withPostID: postID)
                        likeCompletion(likes)
                    }
                }
                post["likedBy"] = likesDict
                post["numberOfLikes"] = likes
                post["dislikedBy"] = dislikesDict
                post["numberOfDislikes"] = dislikes
                currentData.value = post
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, _, _) in
            if let error = error {
                //delegate with fail to like post
                self.delegate?.didFailLiking?(self, error: error.localizedDescription)
            }
        })
    }
    
    public func dislikePost(withPostID postID: String, likedByUserID userID: String, likeCompletion: @escaping (Int) -> Void, dislikeCompletion: @escaping (Int) -> Void) {
        let ref = postsRef.child(postID)
        
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var post = currentData.value as? [String : Any] {
                var dislikesDict = post["dislikedBy"] as? [String : Any] ?? [:]
                var dislikes = post["numberOfDislikes"] as? Int ?? 0
                var likesDict = post["likedBy"] as? [String : Any] ?? [:]
                var likes = post["numberOfLikes"] as? Int ?? 0
                
                //if user has liked already
                if let _ = dislikesDict[userID] {
                    //remove like
                    dislikes -= 1
                    dislikesDict.removeValue(forKey: userID)
                    DispatchQueue.main.async {
                        self.delegate?.didUndoDislikePost?(self, withPostID: postID)
                        dislikeCompletion(dislikes)
                    }
                } else { //if user has not liked yet
                    //add like
                    dislikes += 1
                    dislikesDict[userID] = true
                    
                    if let _ = likesDict[userID] {
                        likes -= 1
                        likesDict.removeValue(forKey: userID)
                        DispatchQueue.main.async {
                            self.delegate?.didUndoLikePost?(self, withPostID: postID)
                            likeCompletion(likes)
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate?.didDislikePost?(self, withPostID: postID)
                        dislikeCompletion(dislikes)
                    }
                }
                post["likedBy"] = likesDict
                post["numberOfLikes"] = likes
                post["dislikedBy"] = dislikesDict
                post["numberOfDislikes"] = dislikes
                currentData.value = post
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, _, _) in
            if let error = error {
                //delegate with fail to like post
                self.delegate?.didFailDisliking?(self, error: error.localizedDescription)
            }
        })
    }
    
    public func likeComment(withCommentID commentID: String, likedByUserID userID: String, likeCompletion: @escaping (Int) -> Void, dislikeCompletion: @escaping (Int) -> Void) {
        let ref = commentsRef.child(commentID)
        
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var comment = currentData.value as? [String : Any] {
                var likesDict = comment["likedBy"] as? [String : Any] ?? [:]
                var likes = comment["numberOfLikes"] as? Int ?? 0
                var dislikesDict = comment["dislikedBy"] as? [String : Any] ?? [:]
                var dislikes = comment["numberOfDislikes"] as? Int ?? 0
                
                //if user has liked already
                if let _ = likesDict[userID] {
                    //remove like
                    likes -= 1
                    likesDict.removeValue(forKey: userID)
                    DispatchQueue.main.async {
                        self.delegate?.didUndoLikeComment?(self)
                        likeCompletion(likes)
                    }
                } else { //if user has not liked yet
                    //add like
                    likes += 1
                    likesDict[userID] = true
                    
                    if let _ = dislikesDict[userID] {
                        dislikes -= 1
                        dislikesDict.removeValue(forKey: userID)
                        DispatchQueue.main.async {
                            self.delegate?.didUndoDislikeComment?(self)
                            dislikeCompletion(dislikes)
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate?.didLikeComment?(self)
                        likeCompletion(likes)
                    }
                }
                comment["likedBy"] = likesDict
                comment["numberOfLikes"] = likes
                comment["dislikedBy"] = dislikesDict
                comment["numberOfDislikes"] = dislikes
                currentData.value = comment
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, _, _) in
            if let error = error {
                //delegate with fail to like post
                self.delegate?.didFailLiking?(self, error: error.localizedDescription)
            }
        })
    }
    
    public func dislikeComment(withCommentID commentID: String, likedByUserID userID: String, likeCompletion: @escaping (Int) -> Void, dislikeCompletion: @escaping (Int) -> Void) {
        let ref = commentsRef.child(commentID)
        
        ref.runTransactionBlock({ (currentData) -> TransactionResult in
            if var comment = currentData.value as? [String : Any] {
                var dislikesDict = comment["dislikedBy"] as? [String : Any] ?? [:]
                var dislikes = comment["numberOfDislikes"] as? Int ?? 0
                var likesDict = comment["likedBy"] as? [String : Any] ?? [:]
                var likes = comment["numberOfLikes"] as? Int ?? 0
                
                //if user has liked already
                if let _ = dislikesDict[userID] {
                    //remove like
                    dislikes -= 1
                    dislikesDict.removeValue(forKey: userID)
                    DispatchQueue.main.async {
                        self.delegate?.didUndoDislikeComment?(self)
                        dislikeCompletion(dislikes)
                    }
                } else { //if user has not liked yet
                    //add like
                    dislikes += 1
                    dislikesDict[userID] = true
                    
                    if let _ = likesDict[userID] {
                        likes -= 1
                        likesDict.removeValue(forKey: userID)
                        DispatchQueue.main.async {
                            self.delegate?.didUndoLikeComment?(self)
                            likeCompletion(likes)
                        }
                    }
                    DispatchQueue.main.async {
                        self.delegate?.didDislikeComment?(self)
                        dislikeCompletion(dislikes)
                    }
                }
                comment["likedBy"] = likesDict
                comment["numberOfLikes"] = likes
                comment["dislikedBy"] = dislikesDict
                comment["numberOfDislikes"] = dislikes
                currentData.value = comment
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, _, _) in
            if let error = error {
                //delegate with fail to like post
                self.delegate?.didFailDisliking?(self, error: error.localizedDescription)
            }
        })
    }
}
