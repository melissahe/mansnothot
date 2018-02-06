//
//  DatabaseService+Add.swift
//  mansnothot
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import FirebaseDatabase

//in the update one, implement the vote changing using FirebaseTransaction

extension DatabaseService {
    //add
    /**
     Adds a comment to the current post.
     
     - Parameters:
        - text: The comment text.
        - postID: The ID of the current, selected post.
     */
    public func addComment(withText text: String, andPostID postID: String) {
        guard let userID = AuthUserService.manager.getCurrentUser()?.uid else {
            print("Error: could not get current user id, please exit the app and log back in.")
            return
        }
        let ref = commentsRef.childByAutoId()
        let comment = Comment(postID: postID, commentID: ref.key, userID: userID, text: text)
        ref.setValue(["postID": postID,
                      "commentID": comment.commentID,
                      "userID": comment.userID,
                      "text": comment.text,
                      "timestamp": comment.timestamp
            ])
        
        print("new comment added to database!!")
    }
    
    /**
     Adds a post from the current user.
     
     - Parameters:
        - category: The selected category for this post.
        - title: The title associated with the current post.
        - bodyText: The text associated with the current post.
        - image: The image associated with the current post.
     */
    public func addPost(withCategory category: String, title: String, bodyText: String?, image: UIImage?) {
        guard let currentUser = AuthUserService.manager.getCurrentUser() else {
            print("Error: could not get current user id, please exit the app and log back in.")
            return
        }
    
        let ref = postsRef.childByAutoId()
        let post = Post(postID: ref.key, category: category, userID: currentUser.uid, title: title, bodyText: bodyText)
        
        ref.setValue(["postID": post.postID,
                      "category": post.category,
                      "userID": post.userID,
                      "title": post.title,
                      "bodyText": post.bodyText ?? "",
                      "numberOfLikes": post.numberOfLikes,
                      "numberOfDislikes": post.numberOfDislikes,
                      "flags": post.flags,
                      "userLiked": post.userLiked,
                      "userDisliked": post.userDisliked,
                      "timestamp": post.timestamp
            ])
        
        StorageService.manager.storePostImage(image: image, withPostID: post.postID) { (errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
            }
        }
        
        print("new post added to database!!")
    }
    
    /**
     Stores a UserProfile object in the database after account creation.
     
     - Parameter userProfile: The UserProfile object passed in.
     */
    public func addUserProfile(_ userProfile: UserProfile, andImage image: UIImage) {
        let ref = usersRef.child(userProfile.userID)
        
        ref.setValue(["email": userProfile.email,
                      "userID": userProfile.userID,
                      "displayName": userProfile.displayName,
                      "bio:": userProfile.bio ?? "",
                      "flags": userProfile.flags
            ])
        
        StorageService.manager.storeUserImage(image: image, withUserID: userProfile.userID) { (errorMessage) in
            if let errorMessage = errorMessage {
                print(errorMessage)
            }
        }
        
        print("new user added to database!!")
    }
    
    /**
     */
    public func addImageURLToPost(url: String, postID: String) {
        addImageURL(url: url, toRef: postsRef, withID: postID)
    }
    
    /**
     */
    public func addImageURLToUser(url: String, userID: String) {
        addImageURL(url: url, toRef: usersRef, withID: userID)
    }
    
    private func addImageURL(url: String, toRef ref: DatabaseReference, withID id: String) {
        ref.child(id).child("imageURL").setValue(url)
        print("added image url")
    }
}
