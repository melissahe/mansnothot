//
//  UserDefaultsHelper.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation

//Note by Melissa: Used to store user info, like settings, default states, etc.
    //we can use this to check if the app has launched before
    //and also if the user is current logged in or logged out
//Also note by Melissa!!: This map (mapping username to email for login) might have to be stored in firebase or something; storing this dict on the phone would mean that if the user has never logged in before on a different device, there is no way to login with just their username because the phone has not mapped their username to an email before

class UserDefaultsHelper {
    private init() {}
    static let manager = UserDefaultsHelper()
    private let userDefaults = UserDefaults.standard
    
    private let userLoggedInKey = "userLoggedIn"
    //maybe stores current user logged in? so we can use this to help us identify which posts in the feed "belong" to the user?
//    private let currentUserIDKey = "currentUserID"
    
    //might not need this since the user logged in monitors the exact same thing, if user is logged in, then it's not their first time, if it's their first time, there's no way they'd be logged in
//    private let firstTimeLaunchKey = "firstTimeLaunch"
//    public func checkIfFirstLaunch() -> Bool {
//        let hasLaunchedBefore = userDefaults.bool(forKey: firstTimeLaunchKey) //false by default
//
//        if !hasLaunchedBefore {
//            userDefaults.set(true, forKey: firstTimeLaunchKey)
//        }
//
//        return hasLaunchedBefore
//    }
    
    //should be called when user logs in or creates account successfully
    public func userLoggedIn(withUserID userID: String) {
        userDefaults.set(true, forKey: userLoggedInKey)
        //store current user id
//        userDefaults.set(userID, forKey: currentUserIDKey)
    }
    //should be called when user signs out
    public func userLoggedOut() {
        userDefaults.set(false, forKey: userLoggedInKey)
        //remove current user id
//        userDefaults.set(nil, forKey: currentUserIDKey)
    }
    //checks if user is logged in, should be switched on in app delegate to present different VCs if logged in/out
    public func userIsLoggedIn() -> Bool {
        return userDefaults.bool(forKey: userLoggedInKey) //if no value stored, is false by default
    }
    //get current user id, which can be used to instantiate the UserProfile model and added to all their posts so they can edit their posts
//    public func getCurrentUserID() -> String? {
//        return userDefaults.string(forKey: currentUserIDKey)
//    }

}

