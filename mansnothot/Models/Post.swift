//
//  Post.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class Post: NSObject {
    let postID: String //should be the same as their index number in the array of posts, this way we can access the same post in the firebase json, and be able to update their posts if needed

    let category: String
    let userID: String //should tie this post back to current user, so they can edit it? maybe we could also just save as userID?
    let title: String
    var bodyText: String?
    var numberOfLikes: Int = 0
    var numberOfDislikes: Int = 0
    var flags: Int = 0
    var imageURL: String?
    var userLiked: Bool = false //should keep track of whether user liked post
    var userDisliked: Bool = false //should keep track of whether user disliked post //if one is true, the other must be false
    var timestamp: Double = Date.timeIntervalSinceReferenceDate
    
    static func ==(lhs: Post, rhs: Post) -> Bool {
        return lhs.userID == rhs.userID && lhs.postID == rhs.postID
    }
    
    init(postID: String, category: String, userID: String, title: String, bodyText: String?) {
        self.postID = postID
        self.category = category
        self.userID = userID
        self.title = title
        self.bodyText = bodyText
        self.imageURL = ""
    }
    
    init(postID: String, category: String, userID: String, title: String, bodyText: String?, numberOfLikes: Int, numberOfDislikes: Int, flags: Int, imageURL: String?, userLiked: Bool, userDisliked: Bool, timestamp: Double) {
        self.postID = postID
        self.category = category
        self.userID = userID
        self.title = title
        self.bodyText = bodyText
        self.numberOfLikes = numberOfLikes
        self.numberOfDislikes = numberOfDislikes
        self.flags = flags
        self.imageURL = imageURL ?? ""
        self.userLiked = userLiked
        self.userDisliked = userDisliked
        self.timestamp = timestamp
    }
}

extension Array where Element == Post {
    func sortedByLikes() -> [Post] {
        return self.sorted(by: { (post1, post2) -> Bool in
            let post1TotalLikes = post1.numberOfLikes - post1.numberOfDislikes
            let post2TotalLikes = post2.numberOfLikes - post2.numberOfDislikes
            return post1TotalLikes > post2TotalLikes
        })
    }
    func sortedByTimestamp() -> [Post] {
        return self.sorted {$0.timestamp > $1.timestamp}
    }
}
