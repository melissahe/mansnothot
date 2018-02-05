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

    let createAccountView = CreateAccountView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(createAccountView)
        createAccountView.emailTextField.delegate = self
        createAccountView.usernameTextField.delegate = self
        createAccountView.passwordTextField.delegate = self
        
        //Action for Create Account Button
        createAccountView.createAccountButton.addTarget(self, action: #selector(newAccountFunc), for: .touchUpInside)
        
    }
    
    @objc private func newAccountFunc() {
        //Firebase function for checking if email already exists should go here
        
        //If it does exist, present an alert that tells the user to pick another email or login in
        
        //If user successfully creates a new account send them back to the Login Screen
        
        let alert = UIAlertController(title: "Success!", message: "Account Created!", preferredStyle: .alert)
        let ok = UIAlertAction(title: "Back to Login", style: .default, handler: {(UIAlertAction) -> Void in self.dismiss(animated: true, completion: nil)})
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}
extension CreateAccountVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let usernameText = createAccountView.usernameTextField.text else {
            createAccountView.statusLabel.text = "Please enter a valid Username"
            return true
        }
        guard let passwordText = createAccountView.passwordTextField.text else {
            createAccountView.statusLabel.text = "Please enter a valid Password"
            return true
        }
        guard let emailText = createAccountView.emailTextField.text else {
            createAccountView.statusLabel.text = "Please enter a valid Email"
            return true
        }
        
        print(usernameText)
        print(passwordText)
        print(emailText)
        
        resignFirstResponder()
        return true
    }
}
