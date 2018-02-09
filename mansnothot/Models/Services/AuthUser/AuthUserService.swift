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

/** This API client is responsible for logging the user in and creating accounts in the Firebase database.
 */
class AuthUserService: NSObject {
    private override init() {
        super.init()
        self.auth = Auth.auth()
    }
    
    /// The singleton object associated with the AuthUserService API client.
    static let manager = AuthUserService()
    private var auth: Auth!
    weak public var delegate: AuthUserServiceDelegate?
    
    //you should generate current user profile using getUserProfile func
    /**
     Logs the user in with their email and password.
     
     - Parameters:
        - email: The email associated with the account.
        - password: The password associated with the account.
     */
    public func login(withEmail email: String, andPassword password: String) {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            if let error = error {
                self.delegate?.didFailLogin?(self, error: error.localizedDescription)
            } else if let user = user {
                if !user.isEmailVerified {
                    self.delegate?.didFailEmailVerification?(self, user: user, error: "Your email is currently not verified. Please check your email and verify your account before proceeding.")
                    
                    self.signOut()
                }
                
                DatabaseService.manager.getUserProfile(withUID: user.uid, completion: { (userProfile) in
//                    self.delegate?.didLogin?(self, userProfile: userProfile)
                    
                    //core data storage
                    
                    self.delegate?.didLogin!(self, userProfile: userProfile)
                })
                print("Logged in")
            }
        }
    }
    
    //first time accounts should add user profile with default placeholder image for image, blank bio and 0 flags
    /**
     Creates an account for the user with their email and password.
     
     - Parameters:
        - email: The email used to make the account.
        - password: The password used to make the account.
        - displayName: The displayName used to make the account.
        - ifNameTaken: A closure that returns only if the displayName is already taken.
     */
    public func createAccount(withEmail email: String, password: String, andDisplayName displayName: String, ifNameTaken: @escaping () -> Void) {
        DatabaseService.manager.checkIfDisplayNameIsTaken(displayName, currentUserID: nil) { (nameIsTaken, oldName, newName) in
            if nameIsTaken {
                ifNameTaken()
                return
            }
            self.auth.createUser(withEmail: email, password: password) { (user, error) in
                if let error = error {
                    self.delegate?.didFailCreatingUser?(self, error: error.localizedDescription)
                }
                if let user = user {
                    user.sendEmailVerification(completion: { (error) in
                        if let error = error {
                            self.delegate?.didFailEmailVerification?(self, user: user, error: error.localizedDescription)
                        } else {
                            self.delegate?.didSendEmailVerification?(self, user: user, message: "A verification email has been sent. Please check your email and verify your account before logging in.")
                        }
                    })
                    
                    let newUserProfile = UserProfile(email: email, userID: user.uid, displayName: displayName, bio: nil, flags: 0, imageURL: nil, isBanned: false)
                    DatabaseService.manager.addUserProfile(newUserProfile, andImage: #imageLiteral(resourceName: "profileImage"))
                    
                    if !user.isEmailVerified {
                        self.signOut()
                    }
                    self.delegate?.didCreateUser?(self, userProfile: newUserProfile)
                }
            }
            
        }
    }
    public func forgotPassword(withEmail email: String) {
        auth.sendPasswordReset(withEmail: email) { (error) in
            if let error = error {
                self.delegate?.didFailForgotPassword?(self, error: error.localizedDescription)
                return
            }
            self.delegate?.didSendForgotPassword?(self)
        }
    }
    
    /**
     Signs the current user out of the app and Firebase.
     */
    public func signOut() {
        do {
            try auth.signOut()
            DatabaseService.manager.stopObserving()
            //core data delete everything
            delegate?.didSignOut?(self)
        } catch {
            print(error)
            delegate?.didFailSignOut?(self, error: error.localizedDescription)
        }
    }
    //can be used to check is user is logged in - if they log in
    
    /// Gets and returns the current user logged into Firebase as a User object. The User object contains info about the user, like phone number, display name, email, etc. Methods can also be called on this User object to do things like send email verification, etc.
    public func getCurrentUser() -> User? {
        return auth.currentUser
    }
    
}
