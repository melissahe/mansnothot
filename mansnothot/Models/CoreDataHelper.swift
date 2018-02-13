//
//  CoreDataHelper.swift
//  mansnothot
//
//  Created by C4Q on 2/9/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHelper {
    private init() {}
    static let manager = CoreDataHelper()
    private var delegate = (UIApplication.shared.delegate as! AppDelegate)
    
    public func getCurrentContext() -> NSManagedObjectContext {
        return delegate.persistentContainer.viewContext
    }
    
    public func saveContext() {
        delegate.saveContext()
    }
    
    public func removeSavedContext(completion: @escaping (_ user: Bool, _ post: Bool) -> Void) {
        let postsFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedPost")
        let postDeleteRequest = NSBatchDeleteRequest(fetchRequest: postsFetch)
        let userFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedUser")
        let userDeleteRequest = NSBatchDeleteRequest(fetchRequest: userFetch)
        
        var postDeleteSuccess = false
        var userDeleteSuccess = false
        
        do {
            try getCurrentContext().execute(postDeleteRequest)
            postDeleteSuccess = true
            try getCurrentContext().execute(userDeleteRequest)
            userDeleteSuccess = true
        } catch {
            print(error)
        }
        completion(userDeleteSuccess, postDeleteSuccess)
    }
    
    public func getSavedUser(completion: @escaping (UserProfile?) -> Void) {
        do {
            let users = try getCurrentContext().fetch(SavedUser.fetchRequest()) as? [SavedUser]
            
            guard let user = users?.first else {
                completion(nil)
                return
            }
            guard let email = user.email, let userID = user.userID, let displayName = user.displayName, let bio = user.bio, let imageURL = user.imageURL else {
                completion(nil)
                return
            }
            let flags = Int(user.flags)
            
            let userProfile = UserProfile(email: email, userID: userID, displayName: displayName, bio: bio, flags: flags, imageURL: imageURL, isBanned: user.isBanned)
            completion(userProfile)
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    public func getExistingUserWithUserID(_ userID: String) -> SavedUser? {
        let fetchRequest = NSFetchRequest<SavedUser>(entityName: "SavedUser")
        let predicate = NSPredicate(format: "userID == %@", userID)
        fetchRequest.predicate = predicate
        
        if let results = try? CoreDataHelper.manager.getCurrentContext().fetch(fetchRequest) {
            return results.first
        }
        
        return nil
    }
    
    public func getSavedPosts(completion: @escaping ([Post]?) -> Void) {
        var posts: [Post] = []
        
        do {
            guard let savedPosts = try getCurrentContext().fetch(SavedPost.fetchRequest()) as? [SavedPost] else {
                completion(nil)
                return
            }
            
            for savedPost in savedPosts {
                guard let postID = savedPost.postID, let category = savedPost.category, let userID = savedPost.userID, let title = savedPost.title, let bodyText = savedPost.bodyText, let imageURL = savedPost.imageURL else {
                    completion(nil)
                    return
                }
                
                let numberOfLikes = Int(savedPost.numberOfLikes)
                let numberOfDislikes = Int(savedPost.numberOfDislikes)
                let timestamp = savedPost.timestamp
                let flags = Int(savedPost.flags)
                
                let post = Post(postID: postID, category: category, userID: userID, title: title, bodyText: bodyText, numberOfLikes: numberOfLikes, numberOfDislikes: numberOfDislikes, flags: flags, imageURL: imageURL, userLiked: false, userDisliked: false, timestamp: timestamp)
                posts.append(post)
            }
            
            completion(posts.sortedByTimestamp())
        } catch {
            print(error)
            completion(nil)
        }
    }
    
    public func getExistingPostWithPostID(_ postID: String) -> SavedPost? {
        do {
            let fetchRequest = NSFetchRequest<SavedPost>(entityName: "SavedPost")
            let predicate = NSPredicate(format: "postID == %@", postID)
            fetchRequest.predicate = predicate
            if let post = try getCurrentContext().fetch(fetchRequest).first {
                return post
            }
        } catch {
            print(error)
        }
        return nil
    }
    
    public func removePost(withPostID postID: String) -> Bool {
        do {
            let fetchRequest = NSFetchRequest<SavedPost>(entityName: "SavedPost")
            let predicate = NSPredicate(format: "postID == %@", postID)
            fetchRequest.predicate = predicate
            if let post = try getCurrentContext().fetch(fetchRequest).first {
                //if post exists
                getCurrentContext().delete(post)
            } else {
                return false
            }
        } catch {
            print(error)
        }
        return false
    }
    
    public func removeAllPosts() -> Bool {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "SavedPost")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try getCurrentContext().execute(deleteRequest)
            getCurrentContext().performAndWait({
                saveContext()
            })
            return true
        } catch {
            print(error)
        }
        return false
    }
}
