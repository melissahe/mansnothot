//
//  ForgotUserView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//might not need this??

//TODO: set up
    //add objects
        //email textfield - should send you the username??
        //rethink logic here - resend email verification??
        //resend username button??
    //set up constraints
    //Firebase function for changing username - i don't think there is one, but i'm not sure

class ForgotUserView: UIView {

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
