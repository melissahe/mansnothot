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
    private init() {
    }
    static let manager = FirebaseAPIClient()
    //singleton objects as variables for easy access

    //delete
    //to do
    
    //update
    //to do
    
    //add more funcs to get email verification, get data, post data, change display name, post comment, etc.
        //firebase auth has functions that let you update the password, change photo url?, and send verification email!!
        //should also include functions to user info (bio, pic, etc.)!!
    
}
