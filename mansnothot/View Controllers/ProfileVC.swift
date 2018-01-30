//
//  ProfileVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//Purpose: to show the user profile in the third tab

//TODO: should have ProfileView as initial view
    //should have a log out button that segues back to the Log In screen and also log out the user (segues back to LoginVC)
    //an alert controller should present on success/failure when changing display name
    //an alert controller should present on success/failure when changing bio
    //the button that allows you to change your profile picture should present an action that presents three options to the user:
        //1. "Photo Library"
        //2. "Take Photo"
        //3. "Cancel" button - just dismisses the alert controller
        //either option 1 or 2 should segue to some ImagePickerViewController or w/e, which will handle the taking of pictures, and maybe uses a delegate function to update this view controller's profile image in real time
    //the button that lets you change display names could display an alert that asks you what to change the name to
    //when users taps bio TextView, it will enter editing mode for the bio (use the textdidbeginediting delegate method) - Will display Alert upon saving successfully (present with dismiss view)
    //the textView should animate from the regular size, and transition to a textview that takes up most of the screen?? And another view (ChangeBioView) will be laid on top, with a new textview that will be in the same place as the old textView, so it looks like there was an actual transition
    //"all my posts" button should segue to AllMyPostsVC with all the user's post

class ProfileVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
