//
//  DatabaseService.swift
//  mansnothot
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

/** This API client is responsible for fetching/pushing data from/to the Firebase database.
 */
class DatabaseService: NSObject {
    private override init() {
        self.rootRef = Database.database().reference()
        self.usersRef = self.rootRef.child("users")
        self.postsRef = self.rootRef.child("posts")
        self.commentsRef = self.rootRef.child("comments")
        super.init()
    }
    
    /** The singleton object for the API client.
     */
    static let manager = DatabaseService()
    
    public weak var delegate: DatabaseServiceDelegate?
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var postsRef: DatabaseReference!
    var commentsRef: DatabaseReference!
    
    //change
    //changing display name - needs test!!
    
    //TODO: finish documentation!!!
    
    /** This method attempts to change the user's displayName.
     
     - Parameters:
     - databaseService: The Firebase/Database API client.
     - error: The error message that occurred when attemping to retrieve posts.
     */
    public func changeDisplayName(to newName: String, ifNameTaken: @escaping (String) -> Void) {
        guard let currentUser = AuthUserService.manager.getCurrentUser() else {
            return
        }
        //check if anyone has same display name, if true, return false
        checkIfDisplayNameIsTaken(newName, currentUserID: currentUser.uid) { (isTaken, oldName, newName)  in
            if isTaken {
                ifNameTaken(newName)
                return
            }
            currentUser.createProfileChangeRequest().displayName = newName
            currentUser.createProfileChangeRequest().commitChanges(completion: { (error) in
                //if change request was not successful
                if let error = error {
                    print(error)
                    self.delegate?.didFailChangingDisplayName?(self, error: error.localizedDescription) //probably because display is already taken?? - can firebase check that?
                    return
                }
                //if successful
                //should alter the display name in the user profile
                let currentUserProfile = FileManagerHelper.manager.getCurrentUser()
                
                currentUserProfile?.displayName = newName
                
                guard let updatedUserProfile = currentUserProfile else {
                    print("current profile is nil!1")
                    return
                }
                FileManagerHelper.manager.addNewUser(updatedUserProfile)
                
                print("changed display name")
                self.delegate?.didChangeDisplayName?(self, oldName: oldName, newName: newName)
            })
        }
    }
    
    //should be in database func
    public func checkIfDisplayNameIsTaken(_ newName: String, currentUserID: String?, completion: @escaping (Bool, String, String) -> Void) {
        usersRef.observeSingleEvent(of: .value) { (dataSnapshot) in
            var oldName: String!
            
            for childSnapShot in dataSnapshot.children.allObjects as! [DataSnapshot] {
                guard let userDict = childSnapShot.value as? [String : Any] else {
                    return
                }
                guard
                    let displayName = userDict["displayName"] as? String,
                    let userID = userDict["userID"] as? String
                    else {
                        return
                }
                
                oldName = displayName
                
                if let currentUserID = currentUserID {
                    if newName == displayName && currentUserID != userID {
                        completion(true, oldName, newName)
                    }
                } else {
                    if newName == displayName {
                        completion(true, oldName, newName)
                    }
                }
            }
            completion(false, oldName, newName)
        }
    }
}
