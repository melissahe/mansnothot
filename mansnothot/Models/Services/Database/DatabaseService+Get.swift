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
    //get
    /** Generates a UserProfile object for the current user from the database.
     
    - Parameters:
        - uid: The unique userID for the current, authenticated user.
        - completion: A closure that executes after a UserProfile is made.
        - userProfile: A UserProfile object for the current user.
     */
    public func getUserProfile(withUID uid: String, completion: @escaping (_ userProfile: UserProfile) -> Void) {
        let ref = usersRef.child(uid)
        
        ref.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let email = dataSnapshot.childSnapshot(forPath: "email").value as? String else {
                return
            }
            guard let displayName = dataSnapshot.childSnapshot(forPath: "displayName").value as? String else {
                return
            }
            let bio = dataSnapshot.childSnapshot(forPath: "bio").value as? String
            let imageURL = dataSnapshot.childSnapshot(forPath: "imageURL").value as? String
            guard let numberOfFlags = dataSnapshot.childSnapshot(forPath: "numberOfFlags").value as? Int else {
                return
            }
            
            let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName, bio: bio, flags: numberOfFlags, imageURL: imageURL)
            completion(currentUserProfile)
        }
    }
    
//    /**
//     Retrieves the unique user ID associated with the given email.
//     
//     - Parameters:
//        - email: The email given by the current user.
//        - completion: A closure that executes after a UserProfile is made.
//        - UID: The unique userID for the current, authenticated user.
//     */
//    public func getUID(fromEmail email: String, completion: @escaping (_ UID: String?) -> Void) {
//        usersRef.observeSingleEvent(of: .value) { (dataSnapshot) in
//            guard let childrenSnapshots = dataSnapshot.children.allObjects as? [DataSnapshot] else {
//                completion(nil)
//                return
//            }
//            
//            for childSnapshot in childrenSnapshots {
//                guard
//                    let userDict = childSnapshot.value as? [String : Any],
//                    let userEmail = userDict["email"] as? String,
//                    let userID = userDict["userID"] as? String
//                else {
//                    completion(nil)
//                    return
//                }
//                
//                if userEmail == email {
//                    completion(userID)
//                    return
//                }
//            }
//        }
//    }
    
    /** Gets all of the posts for a single user. Sorted by timestamp by default from newest to oldest.
    This method returns the posts through the DatabaseServiceDelegate protocol didGetUserPosts(_:, posts:) method.
     
    - Parameters:
        - uid: The unique userID for the current, authenticated user.
     */
    public func getPosts(fromUID uid: String) {
        getAllPosts { (posts) in
            let userPosts = posts.filter{$0.userID == uid}
            
            self.delegate?.didGetUserPosts?(self, posts: userPosts.sortedByTimestamp())
        }
    }
    
    /** Gets all of the posts. Sorted by timestamp by default from newest to oldest.
    This method returns the posts through the DatabaseServiceDelegate protocol didGetAllPosts(_:, posts:) method.
     
    - Parameters:
        - completion: A closure that executes after the posts are retrieved.
        - posts: An array of posts from the current user, sorted from newest to oldest.
     */
    public func getAllPosts(completion: @escaping (_ posts: [Post]) -> Void) {
        postsRef.observe(.value) { (dataSnapshot) in
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
        commentsRef.observe(.value) { (dataSnapshots) in
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
                    let timestamp = commentDict["timestamp"] as? Double,
                    let userID = commentDict["userID"] as? String
                    else {
                        self.delegate?.didFailGettingPostComments?(self, error: "Could not retrieve one of the comments. Some values may be nil.")
                        return
                }
                if postID != passedInPostID {
                    continue
                }
                let comment = Comment(postID: postID, commentID: commentID, userID: userID, text: text, timestamp: timestamp)
                comments.append(comment)
            }
            self.delegate?.didGetPostComments?(self, comments: comments.sortedByTimestamp())
        }
    }
}
