//
//  CreateAccountView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit


class CreateAccountView: UIView {
    
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "dismissButtonIcon"), for: .normal)
        return button
    }()
    
    // Create Account Label
    lazy var createAccountLabel: UILabel = {
        let label = UILabel()
        label.text = "Join Us!"
        Stylesheet.Objects.Labels.AppName.style(label: label)
        return label
    }()
    
    //username textfield
    lazy var usernameTextField: UITextField = {
        let tField = UITextField()
        Stylesheet.Objects.Textfields.UserName.style(textfield: tField)
//        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
//        tField.font = UIFont.systemFont(ofSize: 20, weight: .light)
//        tField.textAlignment = .center
//        //tField.placeholder = "Enter Desired Username"
//        // This will let you pick the color of the placeholder text
//        tField.attributedPlaceholder = NSAttributedString(string: "Enter Desired Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
//        tField.keyboardType = .default
//        tField.keyboardAppearance = .dark
//        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
//        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
//        tField.textColor = .white
        return tField
    }()
    
    //password textfield
    lazy var passwordTextField: UITextField = {
        let tField = UITextField()
        Stylesheet.Objects.Textfields.LoginPassword.style(textfield: tField)
//        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
//        tField.font = UIFont.systemFont(ofSize: 20, weight: .light)
//        tField.textAlignment = .center
//        //tField.placeholder = "Enter Password"
//        // This will let you pick the color of the placeholder text
//        tField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
//        tField.keyboardType = .default
//        tField.keyboardAppearance = .dark
//        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
//        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
//        tField.textColor = .white
//        tField.isSecureTextEntry = true
        return tField
    }()
    
    //email textfield
    lazy var emailTextField: UITextField = {
        let tField = UITextField()
        Stylesheet.Objects.Textfields.LoginEmail.style(textfield: tField)
//        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
//        tField.font = UIFont.systemFont(ofSize: 20, weight: .light)
//        tField.textAlignment = .center
//        //tField.placeholder = "Enter Email"
//        // This will let you pick the color of the placeholder text
//        tField.attributedPlaceholder = NSAttributedString(string: "Enter Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
//        tField.keyboardType = .emailAddress
//        tField.keyboardAppearance = .dark
//        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
//        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
//        tField.textColor = .white
        return tField
    }()
    
    //status label, ex: success/fail to login
    lazy var statusLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Status: "
        lb.backgroundColor = .gray
        lb.textAlignment = .center
        lb.backgroundColor = .white
        lb.textColor = .red
        return lb
    }()
    
    //create account button
    lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create New Account", for: .normal)
        Stylesheet.Objects.Buttons.CreateLink.style(button: button)
//        button.setTitleColor(.black, for: .normal)
//        button.backgroundColor = .yellow
//        button.layer.borderWidth = 0.5
        return button
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
        backgroundColor = .white
        setupObjects()
        setupViews()
    }
    
    private func setupObjects() {
        self.addSubview(dismissButton)
        self.addSubview(createAccountLabel)
        self.addSubview(usernameTextField)
        self.addSubview(passwordTextField)
        self.addSubview(emailTextField)
        self.addSubview(statusLabel)
        self.addSubview(createAccountButton)
    }
    
    private func setupViews() {
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
        }
        
        // create account label
        createAccountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.dismissButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
        }
        
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.createAccountLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }

        //        statusLabel.snp.makeConstraints { (make) in
//            make.top.equalTo(emailTextField.snp.bottom).offset(20)
//            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
//
//        }
        
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.04)
        }
        
        
    }
    
}
