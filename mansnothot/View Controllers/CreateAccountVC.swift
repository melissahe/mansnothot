//
//  CreateAccountVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//Purpose: for creating account with app

//TODO: have CreateAccountView as initial view
    //should have proper textfield delegates for username, password, and email - checking if username exists, password is too short, and if email has been used before?
    //should have proper error messages (maybe as labels, maybe as alerts??) when user account creation fails
    //should use FirebaseAPIClient's create account function to create account
    //if login successful (check from FirebaseAPIClient), should segue to TabBarVC with HomePageVC as first root VC/tab

class CreateAccountVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
