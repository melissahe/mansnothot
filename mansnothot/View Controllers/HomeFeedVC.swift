//
//  HomeFeedVC.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import TableFlip

//Purpose: to present a list of all the posts for the app (including all users)

//TODO: have the HomeFeedView as the initial view
    //should set up datasource variable
    //should add actions to each button (comment, thumbs up, etc.) in a cell through the cell for item at
        //each action should take in a sender, which would be of type FeedTableViewCell, configure the cell to do stuff based on which button is selected
        //comment button - should segue to AddCommentVC
        //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
    //should set up swipe options
        //should present options like "Report User", "Report Post", and "Share To..." (Extra Credit), maybe edit??

class HomeFeedVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
