//
//  ViewController.swift
//  mansnothot
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//Purpose: for logging into app

//TODO: have the login view as the initial view
    //should have proper text field delegates for each textfield
    //should present ForgotPassView (when forgot password button is clicked)
    //should present ForgotUserView (when forgot username button is clicked)
        //maybe included/not included based on how we’ll be logging in (with email only, or email or username)
    //Segue to HomePageVC upon successful log in

    //Maybe?? - we should decide tomorrow, tuesday: have a button at the bottom for if the user wants to create an account? check our group slack channel for the image maggie sent
        //should segue to CreateAccountVC

class LoginVC: UIViewController {
    
    let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.view.addSubview(loginView)
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        
        configureViews()
    }
    
    private func configureViews() {
        self.loginView.welcomeLabel.text = "label test"
        self.loginView.loginButton.addTarget(self, action: #selector(loginToAccount(selector:)), for: UIControlEvents.touchUpInside)
        self.loginView.forgotPassButton.addTarget(self, action: #selector(forgotPass(selector:)), for: UIControlEvents.touchUpInside)
        self.loginView.createNewAccountButton.addTarget(self, action: #selector(createNewAcct(selector:)), for: UIControlEvents.touchUpInside)
    }
    
    @objc func loginToAccount(selector: UIButton) {
        print("Log In button pressed")
    }
    
    @objc func forgotPass(selector: UIButton) {
        print("Forgot Password? button pressed")
        
        // TODO: present ForgotPassView
    }
    
    @objc func createNewAcct(selector: UIButton) {
        print("Create a New Account button pressed")
        
        // TODO: present CreateAccountVC
    }
    
    
}

// Text Field Delegates for each text field
extension LoginVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        // specs for email textfield
        if textField == loginView.emailTextField {
            // check if field is not empty
            guard let userEmail = textField.text, textField.text != "" else { return }
            // TODO: additional checks to verify if user account exists via email
        }
        // specs for password textfield
        if textField == loginView.passwordTextField {
            // check if field is not empty
            guard let userPass = textField.text, textField.text != "" else { return }
            // makes the entered text into secret password form
            textField.isSecureTextEntry = true
        }
    }
    
    // check credentials with Username and Password - Firebase
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}
