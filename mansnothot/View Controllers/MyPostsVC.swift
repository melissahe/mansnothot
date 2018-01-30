//
//  MyPostsVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import TableFlip

//Purpose: shows all of the user's posts

//TODO: have MyPostsView as initial view
    //should have a tableview that shows all of the user's posts
    //should set up datasource variable
    //the cells will have multiple buttons, that can each have their selectors assigned here in the VC, in the cellForRowAt datasource function
        //each action should take in a sender, which would be of type FeedTableViewCell, configure the cell to do stuff based on which button is selected
        //comment button - should segue to AddCommentVC
        //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
        //more info:
            //should set up action sheet that happens during swipe options two buttons “Report User” and “Report Post” (no need for custom view)
            //ReportUser button - functionality for reporting user
            //ReportPost button - functionality for reporting post
            //Nice to have: Share button - Buttons for sharing to Facebook, Email, Instagram, Twitter, Tumblr, SnapChat, etc…
        //should set up swipe options (actually i'm not sure if we're doing this anymore, please refer to the trello)
            //should present options like "Report User", "Report Post", and "Share To..." (Extra Credit), maybe edit??
        //maybe we'll just have edit/delete buttons??
    //maybe should pass in the userID in the initializer so it can get all of the posts from firebase??

class MyPostsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
