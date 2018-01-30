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

    //set up constraints

class ProfileView: UIView {

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
        
    }

}
