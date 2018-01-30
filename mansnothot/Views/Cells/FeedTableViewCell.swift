//
//  FeedTableViewCell.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

//TODO: Set up
    //add objects
        //userImageView - for user image
        //usernameLabel - for user name
        //postImageView - image view in post
        //textView - for post
        //numberOfLikes label - number of likes
        //thumbsUp button - adds to likes
        //numberOfDislikes label - number of dislikes
        //thumbsDown button - adds to dislikes
        //comment button - should segue to AddCommentVC
        //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
    //set up constraints

class FeedTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
