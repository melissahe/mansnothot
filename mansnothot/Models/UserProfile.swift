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

class UserProfile: NSObject, Codable {
    let email: String
    let userID: String //should be from firebase
    var displayName: String
    var bio: String?
    var image: Data? // url?? data?? - wouldn't let me put UIImage, as it didn't conform to codable; firebase auth current user also has a parameter for "photoURL" so we could use that too
    var password: String //might not need this if firebase stores the user profile
    var numberOfFlags: Int
//    var posts: [Post] //we can track posts by using their indices as keys, posts as the values
    
    static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.userID == rhs.userID
    }
    
    init(email: String, userID: String, displayName: String, bio: String?, image: Data?, password: String, numberOfFlags: Int) {
        self.email = email
        self.userID = userID
        self.displayName = displayName
        self.bio = bio
        self.image = image
        self.password = password
        self.numberOfFlags = numberOfFlags
    }
}
