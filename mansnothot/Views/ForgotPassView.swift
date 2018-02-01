//
//  ForgotPassView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//TODO: set up
    //add objects
        //username textfield - email
        //rethink logic here - resend email verification??
        //reset password button??
    //set up constraints
    //Firebase function for changing password

class ForgotPassView: UIView {

    // reset password label
    lazy var resetLabel: UILabel = {
       let label = UILabel()
        label.text = "Enter your email to reset your password"
        label.font = label.font.withSize(15)
        label.textAlignment = .center
        return label
    }()
    
    // email textfield
    lazy var resetEmailTextField: UITextField = {
        let rtf = UITextField()
        rtf.placeholder = "Email Address"
        rtf.borderStyle = .line
        return rtf
    }()
    
    // send reset password email button
    lazy var resetPasswordButton: UIButton = {
       let resetButton = UIButton()
        resetButton.setTitle("Reset Password", for: .normal)
        resetButton.setTitleColor(UIColor.yellow, for: .normal)
        resetButton.backgroundColor = .red
        resetButton.showsTouchWhenHighlighted = true
        return resetButton
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
        setUpViews()
    }
    
    private func setUpViews() {
        setupSubviews()
        setupConstraints()
    }

    private func setupSubviews() {
        addSubview(resetLabel)
        addSubview(resetEmailTextField)
        addSubview(resetPasswordButton)
    }
    
    private func sendButtonTarget() {
        self.resetPasswordButton.addTarget(self, action: #selector(sendPassResetEmail), for: UIControlEvents.touchUpInside)
    }
    

    
    @objc func sendPassResetEmail(selector: UIButton) {
        print("Reset Password button pressed")
        /// TODO: Alert that reset email sent, reroute to Login Page
        
        
        /// TODO: Check if the entered email exists on database
        /// TODO: Firebase send email to reset password.
    }
    
    private func setupConstraints() {
        
        // reset label
        resetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(50)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
        }
        
        // reset email textfield
        resetEmailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(resetLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
            make.height.equalTo(40)
        }
        
        // reset password email button
        resetPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(resetEmailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.6)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
        }
    }
}
