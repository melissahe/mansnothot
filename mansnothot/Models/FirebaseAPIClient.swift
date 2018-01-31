//
//  FirebaseAPIClient.swift
//  mansnothot
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

//Message by Melissa: this should be responsible for:
    //1. user authentication
        //a. creating user account/signing up
        //b. logging in
        //c. reseting password
        //d. sending out verification email???
    //2. database
        //a. get data from database and pass it back to app
        //b. create object and then post data to database

class FirebaseAPIClient {
    private init() {
        self.auth = Auth.auth()
        self.rootRef = Database.database().reference()
        self.usersRef = self.rootRef.child("users")
        self.postsRef = self.rootRef.child("posts")
        self.commentsRef = self.rootRef.child("comments")
    }
    static let manager = FirebaseAPIClient()
    //singleton objects as variables for easy access
    private let auth: Auth!
    private let rootRef: DatabaseReference!
    private let usersRef: DatabaseReference!
    private let postsRef: DatabaseReference!
    private let commentsRef: DatabaseReference!
    
    //you should generate current user profile using getUserProfile func
    public func signIn(with email: String, and password: String, completion: @escaping AuthResultCallback) {
       auth.signIn(withEmail: email, password: password, completion: completion)
    }
    //first time accounts should add user profile with default placeholder image for image, blank bio and 0 flags
    public func createAccount(with email: String, and password: String, completion: @escaping AuthResultCallback) {
        auth.createUser(withEmail: email, password: password, completion: completion)
    }
    
    public func signOut() {
        do {
            try auth.signOut()
            UserDefaultsHelper.manager.userLoggedOut()
        } catch {
            print(error)
        }
    }
    
//    public func getCurrentUserInfo() -> User? {
//        return auth.currentUser //returns info like: phone number, photo url, uid, email, display name, etc., can also check email verification!
//    }
    
    //change
    //changing display name - needs test
    public func changeDisplayName(to newName: String, completion: @escaping (Bool) -> Void) {
        guard let currentUser = auth.currentUser else {
            return
        }
        
        //check if anyone has same display name, if true, return false
        usersRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            for childSnapShot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                guard let userDict = childSnapShot.value as? [String : Any] else {
                    return
                }
                
                if userDict["displayName"] as! String == newName {
                    completion(false)
                }
            }
        }
        
        currentUser.createProfileChangeRequest().displayName = newName
    
        currentUser.createProfileChangeRequest().commitChanges(completion: { (error) in
            //if change request was not successful
            if let error = error {
                print(error)
                completion(false) //probably because display is already taken?? - can firebase check that?
                return
            }
            
            //if successful
            //should alter the display name in the user profile
            self.usersRef.child("\(currentUser.uid)/displayName").setValue(newName)
            print("changed display name")
            completion(true)
        })
    }
    
    //get
    //reads info from current user - doesn't get current image just yet
    public func getUserProfile(withUID uid: String, completion: @escaping (UserProfile) -> Void) {
        
        let ref = usersRef.child(uid)
        
        ref.observeSingleEvent(of: .value) { (dataSnapshot) in
            guard let email = dataSnapshot.childSnapshot(forPath: "email").value as? String else {
                return
            }
            guard let displayName = dataSnapshot.childSnapshot(forPath: "displayName").value as? String else {
                return
            }
            guard let bio = dataSnapshot.childSnapshot(forPath: "bio").value as? String else {
                return
            }
            //we need to figure out what we're doing with the user image
//            guard let imageString = dataSnapshot.childSnapshot(forPath: "image").value as? String else {
//                return
//            }
            guard let password = dataSnapshot.childSnapshot(forPath: "password").value as? String else {
                return
            }
            guard let numberOfFlags = dataSnapshot.childSnapshot(forPath: "numberOfFlags").value as? Int else {
                return
            }
            
            let currentUserProfile = UserProfile(email: email, userID: uid, displayName: displayName, bio: bio, image: nil, password: password, numberOfFlags: numberOfFlags)
            
            completion(currentUserProfile)
        }
        
    }
    
    //gets all of the posts for a single user
    public func getPosts(fromUID uid: String, completion: @escaping ([Post]) -> Void) {
        
        getAllPosts { (posts) in
            let userPosts = posts.filter{$0.userID == uid}
            
            completion(userPosts)
        }
        
    }
    
    //gets all of the posts - for home feed VC
    public func getAllPosts(completion: @escaping ([Post]) -> Void) {
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
                    //need to figure out how we'll be doing image!!
                    let image = postDict["image"] as? String,
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
                
                let post = Post(postID: postID, category: category, userID: userID, title: title, bodyText: bodyText, image: nil, numberOfLikes: numberOfLikes, numberOfDislikes: numberOfDislikes, flags: flags, userLiked: userLiked, userDisliked: userDisliked, timestamp: timestamp)
                
                posts.append(post)
            }
            
            completion(posts)
            
        }
    }
    
    public func getAllComments(fromPost post: Post, completion: @escaping ([Comment]) -> Void) {
        
    }
    
    //add
    public func addPost(forUID uid: String, completion: @escaping (Bool) -> Void) {
        
    }
    
    public func addComment(forPost post: Post, completion: @escaping (Bool) -> Void) {
        
    }
    
    //delete
    //to do
    
    //update
    //to do
    
    //add more funcs to get email verification, get data, post data, change display name, post comment, etc.
        //firebase auth has functions that let you update the password, change photo url?, and send verification email!!
        //should also include functions to user info (bio, pic, etc.)!!
}
