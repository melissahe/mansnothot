//
//  CreateAccountVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
    
    private func setupView() {
        view.addSubview(createAccountView)
        createAccountView.emailTextField.delegate = self
        createAccountView.usernameTextField.delegate = self
        createAccountView.passwordTextField.delegate = self
        
        //Action for Dismiss Button
        createAccountView.dismissButton.addTarget(self, action: #selector(dismissButtonFunc), for: .touchUpInside)
        
        //Action for Create Account Button
        createAccountView.createAccountButton.addTarget(self, action: #selector(newAccountFunc), for: .touchUpInside)
    }
    
    @objc private func dismissButtonFunc() {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    @objc private func newAccountFunc() {
        //Firebase function for checking if email already exists should go here
        
        //If it does exist, present an alert that tells the user to pick another email or login in
        
        //If user successfully creates a new account send them back to the Login Screen
        
        guard let usernameText = createAccountView.usernameTextField.text else {
            createAccountView.statusLabel.text = "Please enter a valid Username"
            return
        }
        guard let passwordText = createAccountView.passwordTextField.text else {
            createAccountView.statusLabel.text = "Please enter a valid Password"
            return
        }
        guard let emailText = createAccountView.emailTextField.text else {
            createAccountView.statusLabel.text = "Please enter a valid Email"
            return
        }
        
        AuthUserService.manager.delegate = self
        AuthUserService.manager.createAccount(withEmail: emailText, password: passwordText, andDisplayName: usernameText) {
            let alert = Alert.create(withTitle: "Error", andMessage: "This display name has already been used.", withPreferredStyle: .alert)
            Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: alert)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
extension CreateAccountVC: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        becomeFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        guard let usernameText = createAccountView.usernameTextField.text else {
//            createAccountView.statusLabel.text = "Please enter a valid Username"
//            return true
//        }
//        guard let passwordText = createAccountView.passwordTextField.text else {
//            createAccountView.statusLabel.text = "Please enter a valid Password"
//            return true
//        }
//        guard let emailText = createAccountView.emailTextField.text else {
//            createAccountView.statusLabel.text = "Please enter a valid Email"
//            return true
//        }
//
//        print(usernameText)
//        print(passwordText)
//        print(emailText)
        
        textField.resignFirstResponder()
        return true
    }
    
    func presentErrorAlert(withErrorMessage message: String) {
        let alertController = Alert.createErrorAlert(withMessage: message)
        self.present(alertController, animated: true, completion: nil)
    }
}

extension CreateAccountVC: AuthUserServiceDelegate {
    func didFailCreatingUser(_ authUserService: AuthUserService, error: String) {
        presentErrorAlert(withErrorMessage: error)
    }
    func didFailEmailVerification(_ authUserService: AuthUserService, user: User, error: String) {
        presentErrorAlert(withErrorMessage: error)
    }
    func didCreateUser(_ authUserService: AuthUserService, userProfile: UserProfile) {
        let alert = Alert.create(withTitle: "Success!", andMessage: "Account Created\nA verification email has been sent to your email, \(self.createAccountView.emailTextField.text!) ", withPreferredStyle: .alert)
        Alert.addAction(withTitle: "Back to Login", style: .default, andHandler: { (_) in
            self.dismiss(animated: true, completion: nil)
        }, to: alert)
        present(alert, animated: true, completion: nil)
    }
}
