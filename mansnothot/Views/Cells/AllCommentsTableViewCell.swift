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

class AllCommentsTableViewCell: UITableViewCell {

    //add objects
    //usernameLabel - for user name
    lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Username and Stuff"
        lb.backgroundColor = .white
        lb.textAlignment = .center
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    //textView - for comment
    lazy var commentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 0.5
        tv.text = "Sample Comment Text Here"
        tv.backgroundColor = .yellow
        tv.textAlignment = .justified
        tv.isEditable = false
        tv.textColor = .black
        return tv
    }()
    
    //nice to have:
    //numberOfLikes label - number of likes
    //thumbsUp button - adds to likes
    //numberOfDislikes label - number of dislikes
    //thumbsDown button - adds to dislikes
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "AllCommentsCell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        self.addSubview(usernameLabel)
        self.addSubview(commentTextView)
        
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        
        commentTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(usernameLabel.snp.bottom)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom)
            make.height.equalTo(self.snp.width).multipliedBy(0.1)
            make.width.equalTo(self.snp.width)
        }
    }

}
