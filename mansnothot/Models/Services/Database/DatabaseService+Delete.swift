//
//  DatabaseService+Delete.swift
//  mansnothot
//
//  Created by C4Q on 2/6/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

extension DatabaseService {
    /**
     */
    public func deletePost(withPostID postID: String) {
        postsRef.child(postID).removeValue { (error, _) in
            if let error = error {
                self.delegate?.didFailDeletingPost?(self, error: error.localizedDescription)
            } else {
                self.delegate?.didDeletePost?(self)
            }
        }
    }
    
    /**
     */
    public func deleteComment(withCommentID commentID: String) {
        commentsRef.child(commentID).removeValue { (error, _) in
            if let error = error {
                self.delegate?.didFailDeletingComment?(self, error: error.localizedDescription)
            } else {
                self.delegate?.didDeleteComment?(self)
            }
        }
    }
    
    /**
     */
    //still a work in progress
    public func deleteAllFromBannedUser(withUserID bannedUserID: String) {
        getAllPosts { (posts) in
            let filteredPosts = posts.filter{$0.userID != bannedUserID}
            
            //delete all posts??
            
            for post in filteredPosts {
                //add post
            }
        }
    }
}
