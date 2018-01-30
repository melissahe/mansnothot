//
//  Post.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Post: Codable, Equatable {
    let id: Int //should be the same as their index number in the array of posts, this way we can access the same post in the firebase json, and be able to update their posts if needed
    var comments: [Comment] //we can track comments by using their indices as keys, comments as the values
    let category: String
    let user: UserProfile //should tie this post back to current user, so they can edit it? maybe we could also just save as userID?
    let title: String
    var bodyText: String
    let image: Data //couldn't put down UIImage
    var likes: Int
    var dislikes: Int
    var flags: Int
    
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.user == rhs.user && lhs.id == rhs.id
    }
}
