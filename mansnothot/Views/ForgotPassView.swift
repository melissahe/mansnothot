//
//  ForgotPassView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class ForgotPassView: UIView {
    
    // dismissable view / button - alternative to the X
    lazy var dismissView: UIButton = {
        let button = UIButton(frame: UIScreen.main.bounds)
        button.backgroundColor = .clear
        return button
    }()
    
    // container view to hold objects
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    // dismiss the view by pressing X
    lazy var dismissButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"dismissButtonIcon"), for: .normal)
        return button
    }()
    
    // reset password label
    lazy var resetLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter your email to reset your password"
        label.textAlignment = .center
        Stylesheet.Objects.Labels.Regular.style(label: label)
        return label
    }()
    
    // email textfield
    lazy var resetEmailTextField: UITextField = {
        let rtf = UITextField()
        Stylesheet.Objects.Textfields.LoginEmail.style(textfield: rtf)
        return rtf
    }()
    
    // send reset password email button
    lazy var resetPasswordButton: UIButton = {
        let resetButton = UIButton()
        resetButton.setTitle("Reset Password", for: .normal)
        Stylesheet.Objects.Buttons.CreateButton.style(button: resetButton)
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
        backgroundColor = .clear
        setUpViews()
    }
    
    private func setUpViews() {
        setupBlurEffectView()
        setupSubviews()
        setupConstraints()
    }
    
    private func setupSubviews() {
        addSubview(dismissView)
        addSubview(containerView)
        addSubview(dismissButton)
        addSubview(resetLabel)
        addSubview(resetEmailTextField)
        addSubview(resetPasswordButton)
    }
    
    private func setupBlurEffectView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark) // .light, .dark, .prominent, .regular, .extraLight
        let visualEffect = UIVisualEffectView(frame: UIScreen.main.bounds)
        visualEffect.effect = blurEffect
        addSubview(visualEffect)
    }
    
    private func setupConstraints() {
        
        // container view to store all the objects
        containerView.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.snp.height).multipliedBy(0.9)
        }
        
        // dismiss X button
        dismissButton.snp.makeConstraints { (make) in
            make.top.equalTo(self.containerView.snp.top).offset(5)
            make.leading.equalTo(self.containerView.snp.leading).offset(5)
        }
        
        // reset label
        resetLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.dismissButton.snp.bottom).offset(10)
            make.centerX.equalTo(self.containerView.snp.centerX)
        }
        
        // reset email textfield
        resetEmailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(resetLabel.snp.bottom).offset(20)
            make.centerX.equalTo(self.containerView.snp.centerX)
            make.width.equalTo(self.containerView.snp.width).multipliedBy(Stylesheet.ConstraintSizes.TextfieldWidthMult)
            make.height.equalTo(Stylesheet.ConstraintSizes.TextfieldHeight)
        }
        
        // reset password email button
        resetPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(resetEmailTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.containerView.snp.centerX)
            make.width.equalTo(self.containerView.snp.width).multipliedBy(Stylesheet.ConstraintSizes.ButtonWidthMult)
            make.height.equalTo(self.containerView.snp.height).multipliedBy(Stylesheet.ConstraintSizes.ButtonHeightMult)
        }
    }
}
