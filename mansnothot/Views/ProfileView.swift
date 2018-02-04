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
        pImageView.contentMode = .scaleAspectFill
        pImageView.backgroundColor = .orange
        return pImageView
    }()
    
    lazy var changeProfileImageButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Change Image", for: .normal)
        btn.setTitleColor(.green, for: .normal)
        btn.titleLabel?.font = UIFont(name: "Arial", size: 15)
        return btn
    }()
    
    lazy var displayName: UILabel = {
        let dn = UILabel()
        dn.text = "Display Label"
        dn.backgroundColor = .yellow
        dn.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        dn.textAlignment = .center
        return dn
    }()
    
    lazy var changeDisplayName: UIButton = {
        let cdn = UIButton()
        cdn.setTitle("Change Username", for: .normal)
        cdn.titleLabel?.font = UIFont(name: "Arial", size: 15)
        cdn.setTitleColor(.green, for: .normal)
        return cdn
    }()
    
    lazy var seeMyPostsButton: UIButton = {
        let cdn = UIButton()
        cdn.setTitle(" See All My Posts ", for: .normal)
        cdn.setTitleColor(.green, for: .normal)
        cdn.layer.borderWidth = 0.5
        return cdn
    }()
    
    // bioTextView
    lazy var bioTextView: UITextView = {
        let btv = UITextView()
        btv.layer.borderWidth = 0.5
        btv.text = "Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang Gucci Gang"
        btv.backgroundColor = .yellow
        btv.textAlignment = .justified
        btv.isEditable = true
        btv.textColor = .black
        //btv.scrollRangeToVisible(NSRangeFromString(bioTextView.text))
        return btv
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        setUpProfile()
        setupNameLabel()
        setupChangeImageButton()
        setupChangeNameButton()
        setupAllMyPostsButton()
        setupBioTextView()
        
        
    }
    
    private func setUpProfile() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(profileImageView.snp.width)
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(spacing)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-400)
        }
    }
    
    private func setupNameLabel() {
        addSubview(displayName)
        displayName.snp.makeConstraints { (make) -> Void in
            //make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(profileImageView.snp.trailing).offset(spacing)
            make.bottom.equalTo(self).offset(-500)
        }
    }
    
    private func setupChangeImageButton() {
        addSubview(changeProfileImageButton)
        changeProfileImageButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(profileImageView.snp.bottom).offset(20)
            make.centerX.equalTo(profileImageView.snp.centerX)
        }
    }
    
    private func setupChangeNameButton() {
        addSubview(changeDisplayName)
        changeDisplayName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(changeProfileImageButton.snp.top)
            make.leading.equalTo(changeProfileImageButton.snp.trailing).offset(76)
        }
    }
    
    private func setupAllMyPostsButton() {
        self.addSubview(seeMyPostsButton)
        seeMyPostsButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(changeProfileImageButton.snp.bottom).offset(30)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
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
