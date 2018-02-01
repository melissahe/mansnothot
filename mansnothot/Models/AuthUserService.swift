//
//  AuthUserService.swift
//  mansnothot
//
//  Created by C4Q on 2/1/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias DisplayNameTaken = Bool

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
    public func logIn(with email: String, and password: String) {
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
    public func createAccount(with email: String, password: String, and displayName: String, ifNameTaken: @escaping (String) -> Void) {
        DatabaseService.manager.checkIfDisplayNameIsTaken(displayName, currentUserID: nil) { (nameIsTaken, oldName, newName) in
            if nameIsTaken {
                ifNameTaken(displayName)
                return
            }
        }
        auth.createUser(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailCreatingUser?(self, error: error)
            }
            if let user = user {
                let newUserProfile = UserProfile(email: email, userID: user.uid, displayName: displayName, bio: "", image: nil, password: password, numberOfFlags: 0)
                //function to save this new user - from database save!!!
                //TODO: !!!!
                self.delegate?.didCreateUser?(self, userProfile: newUserProfile)
            }
        }
    }
    public func signOut() {
        do {
            try auth.signOut()
            //should run a stop monitoring func!!!??
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
