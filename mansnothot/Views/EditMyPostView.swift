//
//  EditMyPostView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//TODO: set up
    //add objects
        //should have a save button - might require different functions to update instead of creating a new post (functions should be in the VC)
        //should have a cancel button
    //set up constraints

class EditMyPostView: NewPostView {

    //it'll reuse the same properties
    //but also need a configure view function to change all the labels and objects, etc.
    
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
