//
//  DatabaseServiceDelegate.swift
//  mansnothot
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

@objc protocol DatabaseServiceDelegate: class {
    //change
    /** This method returns when the displayName for the current user has been successfully changed.
     
    - Parameters:
        - databaseService: The Firebase/Database API client.
        - oldName: The previous displayName.
        - newName: The new displayName.
     */
    @objc optional func didChangeDisplayName(_ databaseService: DatabaseService, oldName: String, newName: String)
    
    /** This method returns when the displayName could not be changed.
     
    - Parameters:
        - databaseService: The Firebase/Database API client.
        - error: The error message that occurred when attempting to change the displayName.
     */
    @objc optional func didFailChangingDisplayName(_ databaseService: DatabaseService, error: String)
    
    //get
    /** This method returns the all posts from the current, authenticated user, sorted from newest to oldest.
     
    - Parameters:
        - databaseService: The Firebase/Database API client.
        - posts: An array of posts from the current user, sorted from newest to oldest.
     */
    
    /**
     */
    @objc optional func didFailAddingUserProfile(_ databaseService: DatabaseService, error: String)
    
    @objc optional func didGetUserPosts(_ databaseService: DatabaseService, posts: [Post])
    
    /** This method returns an error when attempting to retrieve the posts for the current user.
     
    - Parameters:
        - databaseService: The Firebase/Database API client.
        - error: The error message that occurred when attempting to retrieve posts.
     */
    @objc optional func didFailGettingUserPosts(_ databaseService: DatabaseService, error: String)
    
    /** This method returns the all comments from the current, selected post, sorted from newest to oldest.
     
    - Parameters:
        - databaseService: The Firebase/Database API client.
        - comments: An array of comments from the current, selected post, sorted from newest to oldest.
     */
    @objc optional func didGetPostComments(_ databaseService: DatabaseService, comments: [Comment])
    
    /** This method returns an error when attempting to retrieve the comments for the current post.
     
    - Parameters:
        - databaseService: The Firebase/Database API client.
        - error: The error message that occurred when attempting to retrieve comments.
     */
    @objc optional func didFailGettingPostComments(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didAddPost(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailAddingPost(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didAddComment(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailAddingComment(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didDeletePost(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailDeletingPost(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didDeleteComment(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailDeletingComment(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didChangeUserImage(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailChangingUserImage(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didChangeBio(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailChangingBio(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didFailEditingPost(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didEditPost(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didGetBanned(_ databaseService: DatabaseService, message: String)
    
    /**
     */
    @objc optional func didFailBanning(_ databaseService: DatabaseService, error: String)

    /**
     */
    @objc optional func didFlagUserAlready(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didFlagUser(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailFlagging(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didLikePost(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didUndoLikePost(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didDislikePost(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didUndoDislikePost(_ databaseService: DatabaseService)
    
    /**
     */
    @objc optional func didFailLiking(_ databaseService: DatabaseService, error: String)
    
    /**
     */
    @objc optional func didFailDisliking(_ databaseService: DatabaseService, error: String)
}
