//
//  Comment.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class Comment: NSObject {
    let postID: String //so we can identify specific comments from the user
    let commentID: String //this should be the unique comment id
    let userID: String
    var numberOfLikes: Int = 0
    var numberOfDislikes: Int = 0
    var text: String
    var timestamp: Double = Date.timeIntervalSinceReferenceDate
    //bonuses/nice to haves:
    //    var likes: Int
    //    var dislikes: Int
    //    var flags: Int
    
    static func ==(lhs: Comment, rhs: Comment) -> Bool {
        return lhs.postID == rhs.postID && lhs.commentID == rhs.commentID && lhs.userID == rhs.userID
    }
    
    init(postID: String, commentID: String, userID: String, text: String) {
        self.postID = postID
        self.commentID = commentID
        self.userID = userID
        self.text = text
    }
    
    init(postID: String, commentID: String, userID: String, numberOfLikes: Int, numberOfDislikes: Int, text: String, timestamp: Double) {
        self.postID = postID
        self.commentID = commentID
        self.userID = userID
        self.numberOfLikes = numberOfLikes
        self.numberOfDislikes = numberOfDislikes
        self.text = text
        self.timestamp = timestamp
    }
    
}

extension Array where Element == Comment {
    //ADD DOCUMENTATION!!
    func sortedByTimestamp() -> [Comment] {
        return self.sorted {$0.timestamp > $1.timestamp}
    }
}
