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
import SVProgressHUD

class LoginVC: UIViewController {
    
    let loginView = LoginView()
    let forgotPassView = ForgotPassView()
    let createAcctVC = CreateAccountVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Stylesheet.Colors.White
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        configureViews()
        if let user = AuthUserService.manager.getCurrentUser() {
            // currently: if there is a user already logged in, autofill email but need to enter password
            self.loginView.emailTextField.text = user.email
            print("User identified. Display Name: \(String(describing: user.displayName)), Email: \(String(describing: user.email))")
        } else {
            print("there is no user")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        forgotPassView.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let currentUser = AuthUserService.manager.getCurrentUser()
        if currentUser != nil {
            print("on start up: there is a user logged in")
            let tabBar = TabBarVC()
            present(tabBar, animated: false, completion: nil)
        }

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
        self.forgotPassView.resetPasswordButton.addTarget(self, action: #selector(resetPassword), for: UIControlEvents.touchUpInside)
        self.forgotPassView.dismissButton.addTarget(self, action: #selector(returnToLogin), for: .touchUpInside)
        self.forgotPassView.dismissView.addTarget(self, action: #selector(returnToLogin), for: .touchUpInside)
        
    }
    
    @objc func loginToAccount(selector: UIButton) {
        print("Log In button pressed")
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
        
        SVProgressHUD.isVisible()
        SVProgressHUD.show()
        
        AuthUserService.manager.delegate = self
        AuthUserService.manager.login(withEmail: loginView.emailTextField.text!, andPassword: loginView.passwordTextField.text!)
    }
    
    @objc func forgotPass(selector: UIButton) {
        print("Forgot Password? button pressed")
        forgotPassView.isHidden = false
        forgotPassView.resetEmailTextField.text = nil
    }
    
    @objc func createNewAcct(selector: UIButton) {
        print("Create a New Account button pressed")
        present(createAcctVC, animated: true, completion: nil)
    }
    
    @objc func returnToLogin() {
        print("Reset Password or Dismiss View button pressed")
        forgotPassView.isHidden = true
    }
    
    @objc func resetPassword() {
        print("Reset button pressed")
        if currentReachabilityStatus == .notReachable {
            let noInternetAlert = Alert.createErrorAlert(withMessage: "No Internet Connectivity. Please check your network and restart the app.")
            self.present(noInternetAlert, animated: true, completion: nil)
            return
        }
        
        if let emailText = forgotPassView.resetEmailTextField.text, !emailText.isEmpty {
            AuthUserService.manager.delegate = self
            AuthUserService.manager.forgotPassword(withEmail: emailText)
            forgotPassView.isHidden = true
        } else {
            let errorAlert = Alert.createErrorAlert(withMessage: "Nothing was entered in the textfield.")
            self.present(errorAlert, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { alert in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: Text Field Delegates for each text field
extension LoginVC: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        textField.resignFirstResponder()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.becomeFirstResponder()
        // specs for email textfield
        if textField == loginView.emailTextField {
            // check if field is not empty
            guard let userEmail = textField.text, userEmail != "" else { return }
        }
        // specs for password textfield
        if textField == loginView.passwordTextField {
            // check if field is not empty
            guard let userPass = textField.text, userPass != "" else { return }
            // makes the entered text into secret password form
            textField.isSecureTextEntry = true
        }
        // specs for reset password textfield
        if textField == forgotPassView.resetEmailTextField {
            // check if field is not empty
            guard let enteredEmail = textField.text, enteredEmail != "" else { return }
        }
    }

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
        print("Log in successful for \(userProfile.displayName), \(userProfile.email)")
        SVProgressHUD.dismiss()
        self.present(TabBarVC(), animated: true, completion: nil)
        
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
    func didFailForgotPassword(_ authUserService: AuthUserService, error: String) {
        let errorAlert = Alert.createErrorAlert(withMessage: error)
        self.present(errorAlert, animated: true, completion: nil)
    }
    func didSendForgotPassword(_ authUserService: AuthUserService) {
        forgotPassView.isHidden = true
        let alert = Alert.create(withTitle: "An email has been sent to reset your password.", andMessage: nil, withPreferredStyle: .alert)
        Alert.addAction(withTitle: "OK", style: .default, andHandler: nil, to: alert)
        self.present(alert, animated: true, completion: nil)
    }
}
