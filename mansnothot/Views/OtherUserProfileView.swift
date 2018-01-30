//
//  OtherUserProfileView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

//TODO: set up
    //add objects
        //bioTextView - displays the user's bio - should some how instantiate with a textview that is the same size as the one in the profile view transitions to??
        //close button - exits without saving
        //should have their
    //set up constraints

class OtherUserProfileView: UIView {

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
