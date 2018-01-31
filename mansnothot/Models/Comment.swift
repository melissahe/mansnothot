//
//  Comment.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Comment: Codable, Equatable {
    let postID: Int //so we can identify specific comments from the user
    let commentID: Int //this should be the unique comment id
    let userID: String
    var text: String
    //bonuses/nice to haves:
    //    var likes: Int
    //    var dislikes: Int
    //    var flags: Int
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.postID == rhs.postID && lhs.commentID == rhs.commentID && lhs.userID == rhs.userID
    }
}
