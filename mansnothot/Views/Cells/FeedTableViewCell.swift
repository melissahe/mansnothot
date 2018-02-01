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

class FeedTableViewCell: UITableViewCell {
    
    //add objects
    //userImageView - for user image
    //usernameLabel - for user name
    //postImageView - image view in post
    //textView - for post
    //numberOfLikes label - number of likes
    //thumbsUp button - adds to likes
    //numberOfDislikes label - number of dislikes
    //thumbsDown button - adds to dislikes
    //comment button - should segue to AddCommentVC //actually i'm not sure if we're doing this anymore, refer to trello!
    //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
    //flag icon (which is a button) - that will present the flag action sheet
    //set up constraints

    //label
    lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Test"
        lb.backgroundColor = .white
        lb.textAlignment = .center
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "FeedCell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        self.addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp.edges)
        }
    }
    
}
