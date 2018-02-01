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
    
    lazy var profileImageView: UIImageView = {
        var pImageView = UIImageView()
        //pImageView.image = #imageLiteral(resourceName: "profileImage") //place holder image
        pImageView.contentMode = .scaleAspectFill
        pImageView.backgroundColor = .orange
        return pImageView
    }()
    
    lazy var changeProfileImageButton: UIButton = {
    let btn = UIButton()
    btn.setTitle("Change Image", for: .normal)
    btn.setTitleColor(.green, for: .normal)
    btn.addTarget(self, action: #selector(changeImageButtonTapped), for: .touchUpInside)
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
    
    lazy var changedisplayName: UIButton = {
    let cdn = UIButton()
    cdn.setTitle("change Name", for: .normal)
    cdn.setTitleColor(.green, for: .normal)
    cdn.addTarget(self, action: #selector(changeDisplayName), for: .touchUpInside)
    return cdn
    }()
    
    lazy var seeMyPostsButton: UIButton = {
        let cdn = UIButton()
        cdn.setTitle("See All My Posts", for: .normal)
        cdn.setTitleColor(.green, for: .normal)
        cdn.addTarget(self, action: #selector(seePostsButtonTapped), for: .touchUpInside)
        return cdn
    }()
    
//    lazy var logoutButton: UIButton = {
//        let ssmp = UIButton()
//        ssmp.setTitle("See My Posts", for: .normal)
//        ssmp.setTitleColor(., for: <#T##UIControlState#>)
//    }
    //Buttons Func
    @objc func changeImageButtonTapped() {
        //TODO- Allow user to change image by taking them to camera or image
        //TODO ALERTVIEW CONTROLLER WITH ACTION SHEET
    }

    @objc func changeDisplayName() {
        //TODO - ALLOW USER TO CHANGE NAME
    }
    
    @objc func seePostsButtonTapped() {
       //Take user to AllMyPostsVC so SEGUE
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // we get the frame of the UI elements here
        profileImageView.layer.cornerRadius = profileImageView.bounds.height/2
        profileImageView.layer.masksToBounds = true
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
    }
    
    private func setUpProfile() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(profileImageView.snp.width)
            make.top.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-400)
        }
    }
//
//
    private func setupNameLabel() {
        addSubview(displayName)
        displayName.snp.makeConstraints { (make) -> Void in
            //make.top.equalTo(self.safeAreaLayoutGuide).offset(16)
            make.leading.equalTo(profileImageView.snp.trailing).offset(16)
            make.bottom.equalTo(self).offset(-500)
            }
        }
    
    private func setupChangeImageButton() {
        addSubview(changeProfileImageButton)
        changeProfileImageButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(46)
        }
    }
    
    private func setupChangeNameButton() {
        addSubview(changedisplayName)
       changedisplayName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(displayName.snp.bottom).offset(90)
            make.leading.equalTo(changeProfileImageButton.snp.trailing).offset(76)
        }
    }
    
    private func setupAllMyPostsButton() {
        addSubview(seeMyPostsButton)
        seeMyPostsButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(changeProfileImageButton.snp.bottom).offset(70)
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(140)
        }
    }
    
    
}
