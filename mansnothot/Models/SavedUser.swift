//
//  SavedUser.swift
//  mansnothot
//
//  Created by C4Q on 2/9/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

extension SavedUser {
    convenience init(withUserProfile userProfile: UserProfile) {
        self.init(context: CoreDataHelper.manager.getCurrentContext())
        self.email = userProfile.email
        self.userID = userProfile.userID
        self.displayName = userProfile.bio ?? ""
        self.imageURL = userProfile.imageURL ?? ""
        self.flags = Int64(userProfile.flags)
        self.isBanned = userProfile.isBanned
        
    }
}
