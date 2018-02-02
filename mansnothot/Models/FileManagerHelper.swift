//
//  FileManagerHelper.swift
//  mansnothot
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

//Message by Melissa: this will be used to store any larger data persistently that shouldn't be stored in user defaults
    //like maybe current user??
    //maybe can save current user so that loading is really fast for the current user profile
        //should be nil when the user logs out

class FileManagerHelper {
    private init() {}
    static let manager = FileManagerHelper()
    private let fileManager = FileManager.default
    private let currentUserPlist = "currentUser.plist"
    private let encoder = PropertyListEncoder()
    private let decoder = PropertyListDecoder()
    
    private var currentUserProfile: UserProfile? {
      didSet {
        //save function goes here
      }
    }
    
    //document directory
    private func documentDirectory() -> URL {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[0]
    }
    //data file path
    private func dataFilePath(fileName: String) -> URL {
        return documentDirectory().appendingPathComponent(fileName)
    }
    //to finish
    //load
    public func loadCurrentUser() {
        let filePath = dataFilePath(fileName: currentUserPlist)
        
        do {
            let data = try Data.init(contentsOf: filePath)
            let savedUserProfile = try decoder.decode(UserProfile.self, from: data)
            currentUserProfile = savedUserProfile
            print("loaded user profile!!")
        } catch {
            print(error)
            print("couldn't load user profile :(")
        }
    }
    
    //get - //maybe use this to know what posts to get from firebase??
    public func getCurrentUser() -> UserProfile? {
        return currentUserProfile
    }
    
    //save - when saving, it should push changes of current user to firebase??
    private func saveCurrentUser() -> Bool {
        let filePath = dataFilePath(fileName: currentUserPlist)
        
        do {
            let data = try encoder.encode(currentUserProfile)
            try data.write(to: filePath)
            return true
        } catch {
            print(error)
        }
        return false
    }

    //add - when user logs in!!
    public func addNewUser(_ newUserProfile: UserProfile) {
        self.currentUserProfile = newUserProfile
        print("Added new user!")
    }
    
    //delete?? - when user logs out!!
    public func deleteCurrentUser() {
        self.currentUserProfile = nil
        print("Deleted user!")
    }

}
