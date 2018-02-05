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
    
    //username textfield
    lazy var usernameTextField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        tField.textAlignment = .center
        //tField.placeholder = "Enter Desired Username"
        // This will let you pick the color of the placeholder text
        tField.attributedPlaceholder = NSAttributedString(string: "Enter Desired Username", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
        tField.keyboardType = .default
        tField.keyboardAppearance = .dark
        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
        tField.textColor = .white
        return tField
    }()
    
    //password textfield
    lazy var passwordTextField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        tField.textAlignment = .center
        //tField.placeholder = "Enter Password"
        // This will let you pick the color of the placeholder text
        tField.attributedPlaceholder = NSAttributedString(string: "Enter Password", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
        tField.keyboardType = .default
        tField.keyboardAppearance = .dark
        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
        tField.textColor = .white
        tField.isSecureTextEntry = true
        return tField
    }()
    
    //email textfield
    lazy var emailTextField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        tField.textAlignment = .center
        //tField.placeholder = "Enter Email"
        // This will let you pick the color of the placeholder text
        tField.attributedPlaceholder = NSAttributedString(string: "Enter Email", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
        tField.keyboardType = .emailAddress
        tField.keyboardAppearance = .dark
        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
        tField.textColor = .white
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
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Create Account", for: .normal)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 0.5
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
        backgroundColor = .green
        setupObjects()
        setupViews()
    }
    
    private func setupObjects() {
        self.addSubview(usernameTextField)
        self.addSubview(passwordTextField)
        self.addSubview(emailTextField)
        self.addSubview(statusLabel)
        self.addSubview(createAccountButton)
    }
    
    private func setupViews() {
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.08)
        }
        
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.08)
        }
        
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.08)
        }
        
        statusLabel.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.08)
        }
        
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.08)
        }
        
        
    }
    
}
