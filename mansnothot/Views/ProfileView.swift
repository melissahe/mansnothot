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
//        pImageView.contentMode = .scaleAspectFill
//        pImageView.backgroundColor = .orange
        return pImageView
    }()
    
    lazy var changeProfileImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Image", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: btn)
//        btn.setTitleColor(.green, for: .normal)
//        btn.titleLabel?.font = UIFont(name: "Arial", size: 15)
        return btn
    }()
    
    lazy var displayName: UILabel = {
        let dn = UILabel()
        dn.text = "Display Label"
        Stylesheet.Objects.Labels.PostTitle.style(label: dn)
//        dn.backgroundColor = .yellow
//        dn.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
//        dn.textAlignment = .center
//        dn.numberOfLines = 0
        return dn
    }()
    
    lazy var changeDisplayName: UIButton = {
        let cdn = UIButton()
        cdn.setTitle("Change Username", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: cdn)
//        cdn.titleLabel?.font = UIFont(name: "Arial", size: 15)
//        cdn.setTitleColor(.green, for: .normal)
        return cdn
    }()
    
    lazy var seeMyPostsButton: UIButton = {
        let cdn = UIButton()
        cdn.setTitle(" See All My Posts ", for: .normal)
        Stylesheet.Objects.Buttons.Login.style(button: cdn)
//        cdn.setTitleColor(.green, for: .normal)
//        cdn.layer.borderWidth = 0.5
        return cdn
    }()
    
    // bioTextView
    lazy var bioTextView: UITextView = {
        let btv = UITextView()
        btv.text = "Enter a bio"
        Stylesheet.Objects.Textviews.Editable.style(textview: btv)
//        btv.layer.borderWidth = 0.5
//        btv.backgroundColor = .yellow
//        btv.textAlignment = .justified
//        btv.isEditable = true
//        btv.textColor = .black
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
        setupPlusSignButton()
        
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
    
    //Button that goes directly over addAnImage Label
    lazy var plusSignButton: UIButton = {
        let plusSign = UIButton()
        plusSign.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: plusSign)
        //        plusSign.contentMode = .scaleAspectFit
        return plusSign
    }()
    
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
    
    private func setupPlusSignButton() {
        
        self.addSubview(plusSignButton)
        plusSignButton.snp.makeConstraints { (make) in
            make.center.equalTo(profileImageView.snp.center)
            make.edges.equalTo(profileImageView)
        }
    }
}
