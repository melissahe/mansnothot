//
//  ViewController.swift
//  mansnothot
//
//  Created by C4Q on 1/29/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import FirebaseAuth

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
    let forgotPassView = ForgotPassView()
    let createAcctVC = CreateAccountVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        configureViews()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        forgotPassView.isHidden = true

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    private func configureViews() {
        self.view.addSubview(loginView)
        self.loginView.loginButton.addTarget(self, action: #selector(loginToAccount), for: UIControlEvents.touchUpInside)
        self.loginView.forgotPassButton.addTarget(self, action: #selector(forgotPass), for: UIControlEvents.touchUpInside)
        self.loginView.createNewAccountButton.addTarget(self, action: #selector(createNewAcct), for: UIControlEvents.touchUpInside)
        
        self.view.addSubview(forgotPassView)
        self.forgotPassView.resetPasswordButton.addTarget(self, action: #selector(returnToLogin), for: UIControlEvents.touchUpInside) /// update the selector target to sendPassResetEmail when it is configured
        self.forgotPassView.dismissButton.addTarget(self, action: #selector(returnToLogin), for: .touchUpInside)
        self.forgotPassView.dismissView.addTarget(self, action: #selector(returnToLogin), for: .touchUpInside)
        
    }
    
    
    @objc func loginToAccount(selector: UIButton) {
        print("Log In button pressed")
        // Verify credentials through Firebase and then dismiss view to show Tab Bar Controller > Home Feed
        AuthUserService.manager.delegate = self
        AuthUserService.manager.login(withEmail: loginView.emailTextField.text!, andPassword: loginView.passwordTextField.text!)
        // check with Melissa if this is correct, otherwise how to dismiss the view after login?:
        if AuthUserService.manager.getCurrentUser() != nil {
            let user = AuthUserService.manager.getCurrentUser()
            print("User identified")
        }
    }
    
    @objc func forgotPass(selector: UIButton) {
        print("Forgot Password? button pressed")
        // TODO: present ForgotPassView
        forgotPassView.isHidden = false
    }
    
    @objc func createNewAcct(selector: UIButton) {
        print("Create a New Account button pressed")
        present(createAcctVC, animated: true, completion: nil)
    }
    
    @objc func returnToLogin() {
        //        dismiss(animated: true, completion: nil)
        print("Reset Password or Dismiss View button pressed")
        forgotPassView.isHidden = true
        
        
        // segue to Login VC >> Ideally, POP the view and show same original LoginVC
        
    }
    
    @objc func sendPassResetEmail(selector: UIButton) {
        print("Reset Password button pressed")
        
        // temp - dismiss
        //        dismiss(animated: true, completion: nil)
        
        
        /// TODO: Alert that reset email sent, reroute to Login Page
        /// TODO: Check if the entered email exists on database
        /// TODO: Firebase send email to reset password.
    }
    
    /// host this here? not sure
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// Text Field Delegates for each text field
extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.resignFirstResponder()
    }
    
    
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        // specs for email textfield
        if textField == loginView.emailTextField {
            // check if field is not empty
            guard let userEmail = textField.text, textField.text != "" else { return }
            /// TODO: additional checks to verify if user account exists via email
        }
        // specs for password textfield
        if textField == loginView.passwordTextField {
            // check if field is not empty
            guard let userPass = textField.text, textField.text != "" else { return }
            // makes the entered text into secret password form
            textField.isSecureTextEntry = true
        }
        // specs for reset password textfield
        if textField == forgotPassView.resetEmailTextField {
            // check if field is not empty
            guard let enteredEmail = textField.text, textField.text != "" else { return }
            /// TODO: additional checks to verify if user account exists via email
        }
    }
    
    // check credentials with Username and Password - Firebase
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.resignFirstResponder()
    }
}


extension LoginVC: AuthUserServiceDelegate {
    func didFailLogin(_ authUserService: AuthUserService, error: String) {
        showAlert(title: "Incorrect Email/Password", message: "Please try again.")
        print("Login failed")
    }
    
    func didLogin(_ authUserService: AuthUserService, userProfile: UserProfile) {
        print("Log in successful")
        dismiss(animated: true, completion: nil)
        print("LoginVC dismissed")
    }
    
    func didFailEmailVerification(_ authUserService: AuthUserService, user: User, error: String) {
        print("didFailEmailVerification")
        showAlert(title: "Error", message: "\(error)")
    }
    
    func didSendEmailVerification(_ authUserService: AuthUserService, user: User, message: String) {
        print("didSendEmailVerification")
        showAlert(title: "Error", message: "Verification email sent")
    }
}
