//
//  AllCommentsTableViewCell.swift
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
        //usernameLabel - for user name
        //textView - for comment
        //nice to have:
            //numberOfLikes label - number of likes
            //thumbsUp button - adds to likes
            //numberOfDislikes label - number of dislikes
            //thumbsDown button - adds to dislikes
    //set up constraints

class AllCommentsTableViewCell: UITableViewCell {

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
