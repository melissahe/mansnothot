//
//  AuthUserService.swift
//  mansnothot
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

//Message by Melissa: this should be responsible for:
//1. user authentication DONE
    //a. creating user account/signing up DONE
    //b. logging in DONE
    //c. reseting password (forgot password)
    //d. sending out verification email???

typealias DisplayNameTaken = Bool

//TODO: documentation!!
@objc protocol AuthUserServiceDelegate: class {
    @objc optional func didLogin(_ authUserService: AuthUserService, userProfile: UserProfile)
    @objc optional func didFailLogin(_ authUserService: AuthUserService, error: Error)
    @objc optional func didSignOut(_ authUserService: AuthUserService)
    @objc optional func didFailSignOut(_ authUserService: AuthUserService, error: Error)
    @objc optional func didCreateUser(_ authUserService: AuthUserService, userProfile: UserProfile)
    @objc optional func didFailCreatingUser(_ authUserService: AuthUserService, error: Error)
}

class AuthUserService: NSObject {
    private override init() {
        super.init()
        self.auth = Auth.auth()
    }
    
    static let manager = AuthUserService()
    
    private var auth: Auth!
    
    weak public var delegate: AuthUserServiceDelegate?
    
    //you should generate current user profile using getUserProfile func
    //logging in with existing profile
    public func login(with email: String, and password: String) {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailLogin?(self, error: error)
            } else if let user = user {
                DatabaseService.manager.getUserProfile(withUID: user.uid, completion: { (userProfile) in
                    self.delegate?.didLogin?(self, userProfile: userProfile)
                })
            }
        }
    }
    //first time accounts should add user profile with default placeholder image for image, blank bio and 0 flags
    public func createAccount(withEmail email: String, password: String, andDisplayName displayName: String, ifNameTaken: @escaping () -> Void) {
        DatabaseService.manager.checkIfDisplayNameIsTaken(displayName, currentUserID: nil) { (nameIsTaken, oldName, newName) in
            if nameIsTaken {
                ifNameTaken()
            } else {
                self.auth.createUser(withEmail: email, password: password) { (user, error) in
                    if let error = error {
                        self.delegate?.didFailCreatingUser?(self, error: error)
                    }
                    if let user = user {
                        let newUserProfile = UserProfile(email: email, userID: user.uid, displayName: displayName, bio: nil, flags: 0, imageURL: nil)
                        DatabaseService.manager.addUserProfile(newUserProfile)
                        self.delegate?.didCreateUser?(self, userProfile: newUserProfile)
                    }
                }
            }
        }
    }
    public func signOut() {
        do {
            try auth.signOut()
            DatabaseService.manager.stopObserving()
            delegate?.didSignOut?(self)
        } catch {
            print(error)
            delegate?.didFailSignOut?(self, error: error)
        }
    }
    //can be used to check is user is logged in - if they log in
    public func getCurrentUser() -> User? {
        return auth.currentUser //returns info like: phone number, photo url, uid, email, display name, etc., can also check email verification!
    }
    
}
