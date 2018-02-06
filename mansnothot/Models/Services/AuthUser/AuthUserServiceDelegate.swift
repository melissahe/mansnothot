//
//  AuthUserServiceDelegate.swift
//  mansnothot
//
//  Created by C4Q on 2/2/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth

@objc protocol AuthUserServiceDelegate: class {
    /**
     This method is called when user successfully logs in.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
         - userProfile: A UserProfile object associated with the current user.
     */
    @objc optional func didLogin(_ authUserService: AuthUserService, userProfile: UserProfile)
    
    /**
     This method returns an error when attempting to login.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
         - error: The error message that occurred when attempting to login.
     */
    @objc optional func didFailLogin(_ authUserService: AuthUserService, error: String)
    
    /**
     This method is called when user successfully logs out.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
     */
    @objc optional func didSignOut(_ authUserService: AuthUserService)
    
    /**
     This method returns an error when attempting to sign out.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
         - error: The error message that occurred when attempting to sign out.
     */
    @objc optional func didFailSignOut(_ authUserService: AuthUserService, error: String)
    
    /**
     This method is called when the user successfully creates an account.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
         - userProfile: A UserProfile object associated with the current user.
     */
    @objc optional func didCreateUser(_ authUserService: AuthUserService, userProfile: UserProfile)
    
    /**
     This method returns an error when attempting to create an account.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
         - error: The error message that occurred when attempting to create an account.
     */
    @objc optional func didFailCreatingUser(_ authUserService: AuthUserService, error: String)
    
    /**
     This method returns an error when attempting to send a verification email or if the user's email is currently not verified.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
         - user: The User object for the current app session.
         - error: The error message that occurred when attempting to send an email verification or if the user's email is not verified.
     */
    @objc optional func didFailEmailVerification(_ authUserService: AuthUserService, user: User, error: String)
    
    /**
     This method is called when a verification email is successfully sent after creating an account.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
         - user: The User object for the current app session.
         - message: The message when the verification email has been sent.
     */
    @objc optional func didSendEmailVerification(_ authUserService: AuthUserService, user: User, message: String)
    
    /**
     This method returns an error when attempting to send a "Forgot Password" email or if the given email is not a valid email.
     
     - Parameters:
        - authUserService: The Firebase/Auth API Client.
         - error: The error message that occurred when attempting to send a forgot password email or if the given email does not exist within the database.
     */
    @objc optional func didFailForgotPassword(_ authUserService: AuthUserService, error: String)
    
    /**
     This method is called when the "Forgot Password" email is successfully sent.
     
     - Parameters:
         - authUserService: The Firebase/Auth API Client.
     */
    @objc optional func didSendForgotPassword(_ authUserService: AuthUserService)
}
