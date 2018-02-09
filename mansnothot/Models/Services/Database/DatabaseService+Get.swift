//
//  DatabaseService+Get.swift
//  mansnothot
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

extension DatabaseService {

    /** Generates a UserProfile object for the current user from the database.
     
    - Parameters:
        - uid: The unique userID for the current, authenticated user.
        - completion: A closure that executes after a UserProfile is made.
        - userProfile: A UserProfile object for the current user.
     */
    public func getUserProfile(withUID uid: String, completion: @escaping (_ userProfile: UserProfile) -> Void) {
        let ref = usersRef.child(uid)
        ref.observe(.value) { (dataSnapshot) in
            guard let email = dataSnapshot.childSnapshot(forPath: "email").value as? String else {
                return
            }
            guard let displayName = dataSnapshot.childSnapshot(forPath: "displayName").value as? String else {
                return
            }
            let bio = dataSnapshot.childSnapshot(forPath: "bio").value as? String
            let imageURL = dataSnapshot.childSnapshot(forPath: "imageURL").value as? String
            guard let numberOfFlags = dataSnapshot.childSnapshot(forPath: "flags").value as? Int else {
                return
            }
            guard let isBanned = dataSnapshot.childSnapshot(forPath: "isBanned").value as? Bool else {
                return
            }
            
            let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName, bio: bio, flags: numberOfFlags, imageURL: imageURL, isBanned: isBanned)
            completion(currentUserProfile)
        }
    }
    
    /** Gets all of the posts for a single user. Sorted by timestamp by default from newest to oldest.
    This method returns the posts through the DatabaseServiceDelegate protocol didGetUserPosts(_:, posts:) method.
     
    - Parameters:
        - uid: The unique userID for the current, authenticated user.
     */
    public func getPosts(fromUID uid: String, completion: @escaping ([Post]) -> Void) {
        getAllPosts { (posts) in
            let userPosts = posts.filter{$0.userID == uid}
            
            completion(userPosts.sortedByTimestamp())
        }
    }
    
    /** Gets all of the posts. Sorted by timestamp by default from newest to oldest.
    This method returns the posts through the DatabaseServiceDelegate protocol didGetAllPosts(_:, posts:) method.
     
    - Parameters:
        - completion: A closure that executes after the posts are retrieved.
        - posts: An array of posts from the current user, sorted from newest to oldest.
     */
    public func getAllPosts(completion: @escaping (_ posts: [Post]) -> Void) {
        postsRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            var posts: [Post] = []
            guard let postSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                return
            }
            for postSnapshot in postSnapshots {
                guard let postDict = postSnapshot.value as? [String: Any] else {
                    return
                }
                guard
                    let bodyText = postDict["bodyText"] as? String,
                    let category = postDict["category"] as? String,
                    let flags = postDict["flags"] as? Int,
                    let numberOfDislikes = postDict["numberOfDislikes"] as? Int,
                    let numberOfLikes = postDict["numberOfLikes"] as? Int,
                    let postID = postDict["postID"] as? String,
                    let timestamp = postDict["timestamp"] as? Double,
                    let title = postDict["title"] as? String,
                    let userDisliked = postDict["userDisliked"] as? Bool,
                    let userID = postDict["userID"] as? String,
                    let userLiked = postDict["userLiked"] as? Bool
                    else {
                        print("couldn't get post")
                        self.delegate?.didFailGettingPostComments?(self, error: "Could not get posts from database. Please check network connectivity and restart the app.")
                        return
                }
                let imageURL = postDict["imageURL"] as? String
                let post = Post(postID: postID, category: category, userID: userID, title: title, bodyText: bodyText, numberOfLikes: numberOfLikes, numberOfDislikes: numberOfDislikes, flags: flags, imageURL: imageURL, userLiked: userLiked, userDisliked: userDisliked, timestamp: timestamp)
                posts.append(post)
            }
            completion(posts.sortedByTimestamp())
        }
    }
    
    /** Gets all of the comments for a single post. Sorted by timestamp by default from newest to oldest.
     This method returns the posts through the DatabaseServiceDelegate protocol didGetPostComments(_:, comments:) method.
     
    - Parameters:
        - passedInPostID: The unique postID for the current, selected post.
        - comments: An array of comments from the current, selected post, sorted from newest to oldest.
     */
    public func getAllComments(fromPostID passedInPostID: String, completion: @escaping (_ comments: [Comment]) -> Void) {
        commentsRef.observeSingleEvent(of: .value) { (dataSnapshots) in
            guard let commentsSnapshots = dataSnapshots.children.allObjects as? [DataSnapshot] else {
                return
            }
            var comments: [Comment] = []
            for commentSnapshot in commentsSnapshots {
                guard let commentDict = commentSnapshot.value as? [String : Any] else {
                    return
                }
                guard
                    let commentID = commentDict["commentID"] as? String,
                    let postID = commentDict["postID"] as? String,
                    let text = commentDict["text"] as? String,
                    let likes = commentDict["numberOfLikes"] as? Int,
                    let dislikes = commentDict["numberOfDislikes"] as? Int,
                    let timestamp = commentDict["timestamp"] as? Double,
                    let userID = commentDict["userID"] as? String
                    else {
                        self.delegate?.didFailGettingPostComments?(self, error: "Could not retrieve comments. Some values may be nil or check your internet and restart the app.")
                        return
                }
                if postID != passedInPostID {
                    continue
                }
                let comment = Comment(postID: postID, commentID: commentID, userID: userID, numberOfLikes: likes, numberOfDislikes: dislikes, text: text, timestamp: timestamp)
                comments.append(comment)
            }
            completion(comments.sortedByTimestamp())
        }
    }
    
    public func checkIfPostLiked(byUserID userID: String, postID: String, completion: @escaping (Bool) -> Void) {
        let ref = postsRef.child(postID).child("likedBy")
        
        ref.observe(.value) { (dataSnapshot) in
            guard let childrenSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("couldn't check if post was liked")
                return
            }
            
            for child in childrenSnapshot {
                if child.key == userID {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    public func checkIfPostDisliked(byUserID userID: String, postID: String, completion: @escaping (Bool) -> Void) {
        let ref = postsRef.child(postID).child("dislikedBy")
        
        ref.observe(.value) { (dataSnapshot) in
            guard let childrenSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("couldn't check if post was disliked")
                return
            }
            
            for child in childrenSnapshot {
                if child.key == userID {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    public func checkIfCommentLiked(byUserID userID: String, commentID: String, completion: @escaping (Bool) -> Void) {
        let ref = commentsRef.child(commentID).child("likedBy")
        
        ref.observe(.value) { (dataSnapshot) in
            guard let childrenSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("couldn't check if post was liked")
                return
            }
            
            for child in childrenSnapshot {
                if child.key == userID {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    public func checkIfCommentDisliked(byUserID userID: String, commentID: String, completion: @escaping (Bool) -> Void) {
        let ref = commentsRef.child(commentID).child("dislikedBy")
        
        ref.observe(.value) { (dataSnapshot) in
            guard let childrenSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("couldn't check if post was disliked")
                return
            }
            
            for child in childrenSnapshot {
                if child.key == userID {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    public func checkIfPostFlagged(byUserID userID: String, postID: String, completion: @escaping (Bool) -> Void) {
        let ref = postsRef.child(postID).child("flaggedBy")
        
        ref.observe(.value) { (dataSnapshot) in
            guard let childrenSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("couldn't check if post was flagged")
                return
            }
            
            for child in childrenSnapshot {
                if child.key == userID {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
    
    public func checkIfUserFlagged(byUserID userID: String, flaggedUserID: String, completion: @escaping (Bool) -> Void) {
        let ref = usersRef.child(flaggedUserID).child("flaggedBy")
        
        ref.observe(.value) { (dataSnapshot) in
            guard let childrenSnapshot = dataSnapshot.children.allObjects as? [DataSnapshot] else {
                print("couldn't check if user was flagged")
                return
            }
            
            for child in childrenSnapshot {
                if child.key == userID {
                    DispatchQueue.main.async {
                        completion(true)
                    }
                    return
                }
            }
            DispatchQueue.main.async {
                completion(false)
            }
        }
    }
}
