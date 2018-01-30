//
//  LoginView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//TODO: set up
    //add objects
        //username textfield
        //password textfield
        //forgot password button (presents ForgotPassView)
        //forgot username button??? not sure if we should still include this? (presents ForgotUserView)
        //login button
    //set up constraints

class LoginView: UIView {

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
