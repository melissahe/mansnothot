//
//  LoginView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//TODO: set up
//add objects
//username textfield
//password textfield
//forgot password button (presents ForgotPassView)
//forgot username button??? not sure if we should still include this? (presents ForgotUserView)
//login button
//set up constraints

class LoginView: UIView {
    
    // Welcome label?
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "MansNotHot"
//        label.font = Stylesheet.Fonts.Title
//        label.textColor = Stylesheet.Colors.Dark
        
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
        Stylesheet.Objects.Buttons.Login.style(button: loginButton)
        return loginButton
    }()
    
    // Forgot Password? Button - colored link - Present ForgotPassView
    lazy var forgotPassButton: UIButton = {
        let forgotButton = UIButton ()
        forgotButton.setTitle("Forgot Password?", for: .normal)
        Stylesheet.Objects.Buttons.ChangeLink.style(button: forgotButton)
        return forgotButton
    }()
    
    // Create New Account Button - Segue to CreateAccountVC // for testing just click to dismiss the view.
    lazy var createNewAccountButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("Create New Account", for: .normal)
        Stylesheet.Objects.Buttons.CreateLink.style(button: createButton)
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
        }
        
        //email textfield
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }

        //password textfield
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }

        //login button
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.04)
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
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.04)
        }
    }
}
