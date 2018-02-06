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
    public func editPost(withPostID postID: String, newPost newPost: Post, newImage: UIImage?) {
        let ref = postsRef.child(postID)
        
        ref.updateChildValues(["category": newPost.category,
                      "title": newPost.title,
                      "bodyText": newPost.bodyText ?? ""
        ]) { (error, _) in
            if let error = error {
                self.delegate?.didFailEditingPost?(self, error: error.localizedDescription)
            } else if let image = newImage {
                StorageService.manager.storePostImage(image: image, withPostID: postID, completion: { (errorMessage) in
                    if let errorMessage = errorMessage {
                        self.delegate?.didFailEditingPost?(self, error: errorMessage)
                    } else {
                        self.delegate?.didEditPost?(self)
                    }
                })
            } else {
                self.delegate?.didEditPost?(self)
            }
        }
    }
    
    //ban users
    public func banUser(withUserID userID: String) {
        let ref = usersRef.child(userID).child("isBanned")
        
        ref.setValue(true) { (error, _) in
            if let error = error {
                self.delegate?.didFailBanning?(self, error: "Could not ban user: \(error.localizedDescription)")
            }
        }
    }
    
    //needs to incorporate transactions for all of these!
        //should have updating flags - posts
        //should have updating flags - user
        //should have updating likes/dislikes
    
    public func flagUser(withUserID flaggedUserID: String, flaggedByUserID userID: String) {
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
                    self.delegate?.didFlagUser?(self)
                }
                user["flaggedBy"] = flaggedByDict as Any
                user["flags"] = flags as Any
                
                currentData.value = user
             
                return TransactionResult.success(withValue: currentData)
            }
            return TransactionResult.success(withValue: currentData)
        }, andCompletionBlock: { (error, bool, _) in
            if let error = error {
                print(bool)
                //fail to flag
                self.delegate?.didFailFlagging?(self, error: error.localizedDescription)
            } else {
                print(bool)
            }
        })
    }
    
    public func flagPost(withPostID flaggedPostID: String, flaggedByUserID userID: String) {
        
    }
    
    //for likes, there should be separate functions!!
    
    //basically have a new database with flags
    //with a child ref of flagged userID
    //if they haven't flagged before, add them to database??
    //if they have flagged before, return early and call the didFlagAlreadyDelegateMethod
    
}
