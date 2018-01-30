//
//  MyPostsTableViewCell.swift
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
        //usernameLabel - for display name
        //postImageView - for image in post
        //numberOfLikes label - number of likes
        //numberOfDislikes label - number of dislikes
        //edit button - to update post
    //set up constraints

class MyPostsTableViewCell: UITableViewCell {

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
