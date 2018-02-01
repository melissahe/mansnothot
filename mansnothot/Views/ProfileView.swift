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
        pImageView.image = #imageLiteral(resourceName: "profileImage") //place holder image
        pImageView.contentMode = .scaleAspectFill
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
      dn.font = UIFont.systemFont(ofSize: 14, weight: .medium)
      dn.textAlignment = .center
      return dn
    }()
    
    lazy var changedisplayName: UIButton = {
    let cdn = UIButton()
    cdn.setTitle("change Name", for: .normal)
    cdn.setTitleColor(.yellow, for: .normal)
    cdn.addTarget(self, action: #selector(changeDisplayName), for: .touchUpInside)
    return cdn
    }()
    
    lazy var textFieldBio: UITextField = {
        let tf = UITextField()
        tf.backgroundColor = .yellow
        tf.textAlignment = .center
        tf.keyboardType = .numberPad
        tf.keyboardAppearance = .dark
        return tf
    }()
    
    lazy var changeBio: UIButton = {
        let cdn = UIButton()
        cdn.setTitle("change Bio", for: .normal)
        cdn.setTitleColor(.yellow, for: .normal)
        cdn.addTarget(self, action: #selector(changeBioButtonTapped), for: .touchUpInside)
        return cdn
    }()
    
    lazy var allMyPostsButton: UIButton = {
        let cdn = UIButton()
        cdn.setTitle("Go To All Posts", for: .normal)
        cdn.setTitleColor(.yellow, for: .normal)
        cdn.addTarget(self, action: #selector(changeBioButtonTapped), for: .touchUpInside)
        return cdn
    }()
    
    
    //Buttons Func
    @objc func changeImageButtonTapped() {
        //TODO- Allow user to change image by taking them to camera or image
        //TODO ALERTVIEW CONTROLLER WITH ACTION SHEET
    }

    @objc func changeDisplayName() {
        //TODO - ALLOW USER TO CHANGE NAME
    }
    
    @objc func changeBioButtonTapped() {
        //TODO-ALLOW USER TO CHANGE BIO
        //Alert that says saved successfully
    }
    
    @objc func allPostsButtonTapped() {
       //Take user to AllMyPostsVC so SEGUE
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // we get the frame of the UI elements here
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2.0
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
    }
    
    private func setUpProfile() {
        addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.80).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: profileImageView.heightAnchor).isActive = true
    }
    
    private func setupNameLabel() {
        addSubview(displayName)
        displayName.translatesAutoresizingMaskIntoConstraints = false
        displayName.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 16).isActive = true
        displayName.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    private func setupChangeImageButton() {
        addSubview(changeProfileImageButton)
        
    }
    
}
