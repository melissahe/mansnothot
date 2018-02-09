//
//  LoginView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class LoginView: UIView {
    
    // Welcome Label
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "Professional Thoughts"
        Stylesheet.Objects.Labels.AppName.style(label: label)
        return label
    }()
    
    // Email Textfield with Placeholder Text
    lazy var emailTextField: UITextField = {
        let etf = UITextField()
        Stylesheet.Objects.Textfields.LoginEmail.style(textfield: etf)
        return etf
    }()
    
    // Password Textfield with Placeholder Text
    lazy var passwordTextField: UITextField = {
        let ptf = UITextField()
        Stylesheet.Objects.Textfields.LoginPassword.style(textfield: ptf)
        return ptf
    }()
    
    // Login Button - Border - Check credentials via Firebase, then segue to HomePageVC
    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Log In", for: .normal)
        Stylesheet.Objects.Buttons.Login.style(button: loginButton)
        return loginButton
    }()
    
    // Forgot Password? Button - colored link - Present ForgotPassView
    lazy var forgotPassButton: UIButton = {
        let forgotButton = UIButton ()
        forgotButton.setTitle("Forgot Password?", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: forgotButton)
        return forgotButton
    }()
    
    // Create New Account Button - Segue to CreateAccountVC // for testing just click to dismiss the view.
    lazy var createNewAccountButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("Create New Account", for: .normal)
        Stylesheet.Objects.Buttons.CreateButton.style(button: createButton)
        return createButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .clear
        setUpViews()
    }
    
    private func setUpViews() {
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(welcomeLabel)
        addSubview(emailTextField)
        addSubview(passwordTextField)
        addSubview(loginButton)
        addSubview(forgotPassButton)
        addSubview(createNewAccountButton)
    }
    
    private func setupConstraints() {
        
        //welcome label
        welcomeLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.9)
        }
        
        //email textfield
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(Stylesheet.ConstraintSizes.TextfieldWidthMult)
            make.height.equalTo(Stylesheet.ConstraintSizes.TextfieldHeight)
        }

        //password textfield
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(Stylesheet.ConstraintSizes.TextfieldWidthMult)
            make.height.equalTo(Stylesheet.ConstraintSizes.TextfieldHeight)
        }

        //login button
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(Stylesheet.ConstraintSizes.ButtonWidthMult)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(Stylesheet.ConstraintSizes.ButtonHeightMult)
        }

        //forgot password button
        forgotPassButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
        }

        //create account button
        createNewAccountButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(Stylesheet.ConstraintSizes.ButtonWidthMult)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(Stylesheet.ConstraintSizes.ButtonHeightMult)
        }
    }
}
