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

class UserProfile: NSObject{
    let email: String
    let userID: String //should be from firebase
    var displayName: String
    var bio: String?
    var imageURL: String?
    var flags: Int
    var isBanned: Bool
    override var description: String {
        return """
            - email: \(self.email)
            - userID: \(self.userID)
            - displayName: \(self.displayName)
            - bio: \(self.bio ?? "nil")
            - imageURL: \(self.imageURL ?? "nil")
            - flags: \(flags)
        """
    }
//    var posts: [Post] //we can track posts by using their indices as keys, posts as the values
    
    static func ==(lhs: UserProfile, rhs: UserProfile) -> Bool {
        return lhs.userID == rhs.userID
    }
    
    init(email: String, userID: String, displayName: String, bio: String?, flags: Int, imageURL: String?, isBanned: Bool) {
        self.email = email
        self.userID = userID
        self.displayName = displayName
        self.bio = bio
        self.flags = flags
        self.imageURL = imageURL ?? ""
        self.isBanned = isBanned
    }
}
