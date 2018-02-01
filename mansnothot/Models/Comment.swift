//
//  Comment.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct Comment: Codable, Equatable {
    let postID: String //so we can identify specific comments from the user
    let commentID: String //this should be the unique comment id
    let userID: String
    var text: String
    let timestamp: Double
    //bonuses/nice to haves:
    //    var likes: Int
    //    var dislikes: Int
    //    var flags: Int
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.postID == rhs.postID && lhs.commentID == rhs.commentID && lhs.userID == rhs.userID
    }
}

extension Array where Element == Comment {
    func sortedByTimestamp() -> [Comment] {
        return self.sorted {$0.timestamp > $1.timestamp}
    }
}
