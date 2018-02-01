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
        return label
    }()
    
    // email textfield
    lazy var resetEmailTextField: UITextField = {
        let rtf = UITextField()
        rtf.placeholder = "Email Address"
        return rtf
    }()
    
    // send reset password email button
    lazy var resetPasswordButton: UIButton = {
       let resetButton = UIButton()
        resetButton.setTitle("Send Reset Password Email", for: .normal)
        resetButton.setTitleColor(UIColor.lightGray, for: .normal)
        resetButton.backgroundColor = .red
        resetButton.showsTouchWhenHighlighted = true
        return resetButton
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
        addSubview(resetLabel)
        addSubview(resetEmailTextField)
        addSubview(resetPasswordButton)
    }
    
    private func setupConstraints() {
        
        // reset label
        resetLabel.snp.makeConstraints { (make) in
            make.top.equalTo((superview?.snp.top)!).offset(50)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.8)
        }
        
        // reset email textfield
        resetEmailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(resetLabel.snp.bottom).offset(20)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.8)
        }
        
        // reset password email button
        resetPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(resetEmailTextField.snp.bottom).offset(20)
            make.centerX.equalTo((superview?.snp.centerX)!)
            make.width.equalTo((superview?.snp.width)!).multipliedBy(0.5)
            make.height.equalTo((superview?.snp.height)!).multipliedBy(0.1)
        }
    }
}
