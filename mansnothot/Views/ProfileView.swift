//
//  ProfileView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

//TODO: set up
//add objects
//profileImageView - for profile image
//button to change profileImage - should be set up in the ProfileVC to segue to the ImagePickerViewController
//displayName label - for user display name
//changeDisplayName button - should present an alert that lets them change names?
//bioTextView - displays the user's bio
//allMyPostsButton - will segue to AllMyPostsVC, which displays all of the posts of the user



class ProfileView: UIView {
    
    var spacing = 16 //Use this for even spacing
    
    lazy var profileImageView: UIImageView = {
        var pImageView = UIImageView()
        pImageView.image = #imageLiteral(resourceName: "profileImage") //place holder image
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: pImageView)
        pImageView.isUserInteractionEnabled = true
        return pImageView
    }()
    
    lazy var changeProfileImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Image", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: btn)
        return btn
    }()
    
    lazy var displayName: UILabel = {
        let dn = UILabel()
        dn.text = "Display Label"
        Stylesheet.Objects.Labels.PostTitle.style(label: dn)
        return dn
    }()
    
    lazy var changeDisplayName: UIButton = {
        let cdn = UIButton()
        cdn.setTitle("Change Username", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: cdn)
        return cdn
    }()
    
    lazy var seeMyPostsButton: UIButton = {
        let cdn = UIButton()
        cdn.setTitle(" See All My Posts ", for: .normal)
        Stylesheet.Objects.Buttons.Login.style(button: cdn)
        return cdn
    }()
    
    // bioTextView
    lazy var bioTextView: UITextView = {
        let btv = UITextView()
        btv.text = "Enter a bio"
        Stylesheet.Objects.Textviews.Editable.style(textview: btv)
        return btv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // we get the frame of the UI elements here
        profileImageView.layer.cornerRadius = profileImageView.bounds.height/2
        profileImageView.layer.masksToBounds = true
        bioTextView.scrollRangeToVisible(NSRangeFromString(bioTextView.text))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        setUpProfileImageView()
        setupNameLabel()
        setupChangeNameButton()
        setupChangeImageButton()
        setupAllMyPostsButton()
        setupBioTextView()
    }
    
    private func setUpProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(spacing)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(spacing)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
            make.width.equalTo(profileImageView.snp.height)
        }
    }
    
    private func setupNameLabel() {
        addSubview(displayName)
        displayName.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(profileImageView.snp.trailing).offset(spacing)
            make.bottom.equalTo(profileImageView.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(-spacing)
        }
    }
    
    
    private func setupChangeNameButton() {
        addSubview(changeDisplayName)
        changeDisplayName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(displayName.snp.bottom).offset(5)
            make.leading.equalTo(displayName.snp.leading)
        }
    }
    
    private func setupChangeImageButton() {
        addSubview(changeProfileImageButton)
        changeProfileImageButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(changeDisplayName.snp.bottom)
            make.leading.equalTo(displayName.snp.leading)
        }
    }

    private func setupAllMyPostsButton() {
        self.addSubview(seeMyPostsButton)
        seeMyPostsButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(changeProfileImageButton.snp.bottom).offset(30)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(Stylesheet.ConstraintSizes.ButtonWidthMult)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(Stylesheet.ConstraintSizes.ButtonHeightMult)
        }
    }
    
    private func setupBioTextView() {
        self.addSubview(bioTextView)
        bioTextView.snp.makeConstraints { (make) in
            make.top.equalTo(seeMyPostsButton.snp.bottom).offset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-spacing)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(spacing)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-spacing)
            
        }
    }
}
