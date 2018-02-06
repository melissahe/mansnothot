//
//  OtherUserProfileVC.swift
//  mansnothot
//
//  Created by Richard Crichlow on 2/4/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class OtherUserProfileVC: UIViewController {

    let otherUserView = OtherUserProfileView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    private func setupViews() {
        view.addSubview(otherUserView)
    }
    
    public func setupOtherUserProfile(user: UserProfile){
        otherUserView.bioTextView.text = user.bio
        otherUserView.displayName.text = user.displayName
        //otherUserView.profileImageView.image = user.imageURL
    }

}
