//
//  FirebaseAPIClient.swift
//  mansnothot
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase

//Message by Melissa: this should be responsible for:
    //1. user authentication
        //a. creating user account/signing up
        //b. logging in
        //c. reseting password
        //d. sending out verification email???
    //2. database
        //a. get data from database and pass it back to app
        //b. create object and then post data to database

class FirebaseAPIClient {
    private init() {}
    static let manager = FirebaseAPIClient()
    //singleton objects as variables for easy access
    private let auth = Auth.auth()
    private let database = Database.database()
    
    public func signUp(with email: String, and password: String, completion: @escaping AuthResultCallback) {
       auth.signIn(withEmail: email, password: password, completion: completion)
    }
    
    public func createAccount(with email: String, and password: String, completion: @escaping AuthResultCallback) {
        auth.createUser(withEmail: email, password: password, completion: completion)
    }
    
    public func signOut() {
        do {
            try auth.signOut()
            UserDefaultsHelper.manager.userLoggedOut()
        } catch {
            print(error)
        }
    }
    
    public func getCurrentUserInfo() -> User? {
        return auth.currentUser //returns info like: phone number, photo url, uid, email, display name, etc., can also check email verification!
    }
    //changing display name
    public func changeDisplayName(to newName: String, completion: @escaping (Bool) -> Void) {
        //TODO: possible handling here to check if anyone has the same display name in firebase?
        
        auth.currentUser?.createProfileChangeRequest().displayName = newName
    
        auth.currentUser?.createProfileChangeRequest().commitChanges(completion: { (error) in
            //if change request was not successful
            if let error = error {
                print(error)
                completion(false) //probably because display is already taken?? - can firebase check that?
                return
            }
            
            //if successful
            completion(true)
        })
    }
    
    //add more funcs to get email verification, get data, post data, change display name, post comment, etc.
        //firebase auth has functions that let you update the password, change photo url?, and send verification email!!
        //should also include functions to user info (bio, pic, etc.)!!
}
