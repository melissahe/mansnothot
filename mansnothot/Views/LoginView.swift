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
        label.text = "Welcome to Man's Not Hot"
        label.font = label.font.withSize(20)
        return label
    }()
    
    // Email Textfield with Placeholder Text
    lazy var emailTextField: UITextField = {
        let etf = UITextField()
        etf.placeholder = "Email Address"
        return etf
    }()
    
    // Password Textfield with Placeholder Text
    lazy var passwordTextField: UITextField = {
        let ptf = UITextField()
        ptf.placeholder = "Password"
        return ptf
    }()
    
    // Login Button - Border - Check credentials via Firebase, then segue to HomePageVC
    lazy var loginButton: UIButton = {
        let loginButton = UIButton()
        loginButton.setTitle("Login or Log In", for: .normal)
        loginButton.setTitleColor(UIColor.lightGray, for: .normal)
        loginButton.showsTouchWhenHighlighted = true
        loginButton.backgroundColor = UIColor.red
        return loginButton
    }()
    
    // Forgot Password? Button - colored link - Present ForgotPassView
    lazy var forgotPassButton: UIButton = {
        let forgotButton = UIButton ()
        forgotButton.setTitle("Forgot Password?", for: .normal)
        forgotButton.setTitleColor(UIColor.blue, for: .normal)
        forgotButton.backgroundColor = UIColor.yellow // bg color just to make button visible
        forgotButton.showsTouchWhenHighlighted = true
        return forgotButton
    }()
    
    // Create New Account Button - Segue to CreateAccountVC // for testing just click to dismiss the view.
    lazy var createNewAccountButton: UIButton = {
        let createButton = UIButton()
        createButton.setTitle("Create a New Account", for: .normal)
        createButton.setTitleColor(UIColor.red, for: .normal)
        createButton.showsTouchWhenHighlighted = true
        createButton.backgroundColor = UIColor.lightGray
        createButton.showsTouchWhenHighlighted = true
        return createButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .white
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
            make.top.equalTo((superview?.snp.top)!).offset(20)
            make.centerX.equalTo((superview?.snp.centerX)!)
        }
        
        //email textfield
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(welcomeLabel.snp.top).offset(20)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.8)
        }
        
        //password textfield
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.8)
        }
        
        //login button
        loginButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.5)
            make.height.equalTo((superview?.snp.height)!).multipliedBy(0.1)
        }
        
        //forgot password button
        forgotPassButton.snp.makeConstraints { (make) in
            make.top.equalTo(loginButton.snp.bottom).offset(10)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.5)
            make.height.equalTo((superview?.snp.height)!).multipliedBy(0.1)
        }
        
        //create account button
        createNewAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo((superview?.snp.bottom)!).offset(-20)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.5)
            make.height.equalTo((superview?.snp.height)!).multipliedBy(0.1)
        }
    }
}
