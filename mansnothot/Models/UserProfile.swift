//
//  UserProfile.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import FirebaseAuth

//Message by Melissa: the struct we'll use for each user

struct UserProfile: Codable, Equatable {
    let email: String
    let userID: String //should be from firebase
    var displayName: String
    var bio: String
    var image: Data // url?? data?? - wouldn't let me put UIImage, as it didn't conform to codable; firebase auth current user also has a parameter for "photoURL" so we could use that too
    var password: String
    var numberOfFlags: Int
//    var posts: [Post] //we can track posts by using their indices as keys, posts as the values
    
    static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.userID == rhs.userID
    }
    
    //maybe if we always use user to instantiate a user profile
//    static func getUserProfile(from user: User) -> UserProfile {
//        return
//    }
}
