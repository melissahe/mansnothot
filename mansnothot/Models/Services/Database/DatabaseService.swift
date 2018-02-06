//
//  DatabaseService.swift
//  mansnothot
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseDatabase

//Message by Melissa: this should be responsible for:
//2. database
    //a. get data from database and pass it back to app
    //b. create object and then post data to database

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
    
    /// The singleton object for the DatabaseService API client.
    static let manager = DatabaseService()
    
    public weak var delegate: DatabaseServiceDelegate?
    
    var rootRef: DatabaseReference!
    var usersRef: DatabaseReference!
    var postsRef: DatabaseReference!
    var commentsRef: DatabaseReference!
    
    /**
     Removes all observers from all references.
    */
    public func stopObserving() {
        rootRef.removeAllObservers()
        postsRef.removeAllObservers()
        usersRef.removeAllObservers()
        commentsRef.removeAllObservers()
    }
    
    //change
    //changing display name - needs test!!
    /** This method attempts to change the user's displayName.
    If the name change is successful, it will return the old and new displayNames through the DatabaseServiceDelegate protocol didChangeDisplayName(_:, oldName:, newName:) method.
    If the name change is not successful, it will return a localized error message through the DatabaseServiceDelegate protocol didFailChangingDisplayName?(_:, error:) method.
     
    - Parameters:
        - newName: The new name to change to.
        - ifNameTaken: A closure that passes the new name back if it is currently in used by a different user.
        - failedName: The name that is already in use by another user.
     */
    public func changeDisplayName(to newName: String, ifNameTaken: @escaping (_ failedName: String) -> Void) {
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
                //if successful - should alter the display name in the user profile
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
    
    /** This method checks if the given displayName is already in use by another user.
     
    - Parameters:
        - newName: The new name to change to.
        - currentUserID: The ID of the current, authorized user.
        - completion: A closure that passes back a Bool (whether the name is in use or not), the oldName, and the newName.
        - isTaken: If the name is taken or not.
        - oldName: The previous displayName of the current user.
        - newName: The new displayName of the current user.
     */
    public func checkIfDisplayNameIsTaken(_ newName: String, currentUserID: String?, completion: @escaping (_ isTaken: Bool, _ oldName: String, _ newName: String) -> Void) {
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
                        return
                    }
                } else {
                    if newName == displayName {
                        completion(true, oldName, newName)
                        return
                    }
                }
            }
            if let oldName = oldName {
                completion(false, oldName, newName)
                return
            } else {
                completion(false, newName, newName)
                return
            }
        }
    }
    
    /**
     */
    //this should be run in app delegate?? logInVC/homefeedview - it will observe forever
    public func checkForBan() {
        if let currentUser = AuthUserService.manager.getCurrentUser() {
            usersRef.child(currentUser.uid).child("isBanned").observe(.value, with: { (snapshot) in
                
                if let isBanned = snapshot.value as? Bool {
                    if isBanned {
                        self.delegate?.didGetBanned?(self, message: "You have been banned for being flagged too many times. Someone needs to have better thot thoughts!!")
                        AuthUserService.manager.signOut()
                    }
                }
            })
        }
    }
}
