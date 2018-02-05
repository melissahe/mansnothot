//
//  OtherUserProfileView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//TODO: set up
    //add objects
        //bioTextView - displays the user's bio - should some how instantiate with a textview that is the same size as the one in the profile view transitions to??
        //close button - exits without saving
        //should have their
    //set up constraints

class OtherUserProfileView: UIView {

    var spacing = 16 //Use this for even spacing
    
    lazy var profileImageView: UIImageView = {
        var pImageView = UIImageView()
        pImageView.image = nil //place holder image
        pImageView.contentMode = .scaleAspectFill
        pImageView.backgroundColor = .orange
        return pImageView
    }()
    
    lazy var displayName: UILabel = {
        let dn = UILabel()
        dn.text = "Other UserName Label"
        dn.backgroundColor = .yellow
        dn.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        dn.textAlignment = .center
        dn.numberOfLines = 0
        return dn
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
        setupBioTextView()
    }
    
    private func setUpProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(spacing)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.2)
            make.width.equalTo(profileImageView.snp.height)
        }
    }
    
    private func setupNameLabel() {
        addSubview(displayName)
        displayName.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(profileImageView.snp.bottom).offset(spacing)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.8)
        }
    }
    
    private func setupBioTextView() {
        self.addSubview(bioTextView)
        bioTextView.snp.makeConstraints { (make) in
            make.top.equalTo(displayName.snp.bottom).offset(spacing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-spacing)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(spacing)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-spacing)
            
        }
    }


}
