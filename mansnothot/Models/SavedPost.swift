//
//  SavedPost.swift
//  mansnothot
//
//  Created by C4Q on 2/9/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import CoreData

extension SavedPost {
    convenience init(fromPost post: Post, andUser user: SavedUser) {
        self.init(context: CoreDataHelper.manager.getCurrentContext())
        self.userID = post.userID
        self.title = post.title
        self.timestamp = post.timestamp
        self.postID = post.postID
        self.numberOfLikes = Int64(post.numberOfLikes)
        self.numberOfDislikes = Int64(post.numberOfDislikes)
        self.imageURL = post.imageURL ?? ""
        self.category = post.category
        self.bodyText = post.bodyText ?? ""
        CoreDataHelper.manager.saveContext()
    }
}
