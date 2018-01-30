//
//  Comment.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Comment: Codable, Equatable {
    let post: Post //so we can identify specific comments from the user
    let id: Int //should be the same as their index number in the array of comments, this way we can access the same comments in the firebase json, and be able to update their comments if needed
    var text: String
    //bonuses/nice to haves:
    //    var likes: Int
    //    var dislikes: Int
    //    var flags: Int
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.post == rhs.post && lhs.id == rhs.id
    }
}
