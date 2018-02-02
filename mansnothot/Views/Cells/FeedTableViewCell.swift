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
    
    
    
    //userImageView - for user image
    lazy var userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    //categoryLabel - for Post Category
    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category"
        lb.backgroundColor = .white
        lb.textAlignment = .left
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    //usernameLabel - for user name
    lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Test"
        lb.backgroundColor = .white
        lb.textAlignment = .left
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    //postTitleLabel - for user name
    lazy var postTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Post Title"
        lb.backgroundColor = .white
        lb.textAlignment = .left
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    //postImageView - image view in post
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.backgroundColor = .green
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    //textView - for post
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 0.5
        tv.text = "Sample Post Text Here"
        tv.backgroundColor = .yellow
        tv.textAlignment = .justified
        tv.isEditable = false
        return tv
    }()
    
    //thumbsUp button - adds to likes
    lazy var thumbsUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "thumbsUp"), for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 0.5
        return button
    }()
    
    //numberOfLikes label - number of likes
    lazy var numberOfLikesLabel: UILabel = {
        let lb = UILabel()
        lb.text = "+37"
        lb.backgroundColor = .gray
        lb.textAlignment = .center
        lb.backgroundColor = .white
        return lb
    }()
    
    //thumbsDown button - adds to dislikes
    lazy var thumbsDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "thumbsDown"), for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 0.5
        return button
    }()
    
    //numberOfDislikes label - number of dislikes
    lazy var numberOfDislikesLabel: UILabel = {
        let lb = UILabel()
        lb.text = "-7"
        lb.backgroundColor = .gray
        lb.textAlignment = .center
        lb.backgroundColor = .white
        return lb
    }()
    
    
    //comment button - should segue to AddCommentVC //actually i'm not sure if we're doing this anymore, refer to trello!
    lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 0.5
        return button
    }()
    
    //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
    lazy var showThreadButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Thread", for: .normal)
        button.backgroundColor = .orange
        button.layer.borderWidth = 0.5
        
        return button
    }()
    
    //flag icon (which is a button) - that will present the flag action sheet
    lazy var flagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "flag"), for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 0.5
        return button
    }()
    
    //Share Button
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Share", for: .normal)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 0.5
        return button
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
        // here you get the actual frame size of the elements before getting laid out on screen
        super.layoutSubviews()
        self.backgroundColor = .clear
        setupAndConstrainObjects()
        
        // To add round edges
        userImageView.layer.cornerRadius = userImageView.bounds.width / 6.0
        userImageView.layer.masksToBounds = true
    }
    
    private func setupAndConstrainObjects(){
        self.addSubview(flagButton)
        self.addSubview(userImageView)
        self.addSubview(categoryLabel)
        self.addSubview(usernameLabel)
        self.addSubview(postTitleLabel)
        self.addSubview(postImageView)
        self.addSubview(postTextView)
        self.addSubview(thumbsUpButton)
        self.addSubview(numberOfLikesLabel)
        self.addSubview(thumbsDownButton)
        self.addSubview(numberOfDislikesLabel)
        self.addSubview(showThreadButton)
        self.addSubview(commentButton)
        self.addSubview(shareButton)
        
        userImageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.snp.width).multipliedBy(0.08)
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
        categoryLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.height.equalTo(userImageView.snp.height).multipliedBy(0.5)
        }
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(categoryLabel.snp.bottom)
            make.leading.equalTo(userImageView.snp.trailing).offset(5)
            make.height.equalTo(userImageView.snp.height).multipliedBy(0.5)
        }
        postTitleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.top.equalTo(usernameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
//            make.height.equalTo(self.snp.height).multipliedBy(0.16)
        }
        postTextView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.snp.width).multipliedBy(0.8)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            make.centerX.equalTo(self.snp.centerX)
            make.top.equalTo(postImageView.snp.bottom).offset(5)
        }
        thumbsUpButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
        numberOfLikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsUpButton.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(postTitleLabel.snp.height)
        }
        thumbsDownButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(numberOfLikesLabel.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
        }
        numberOfDislikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsDownButton.snp.trailing)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(postTitleLabel.snp.height)
        }
        showThreadButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(numberOfDislikesLabel.snp.height)
            make.width.equalTo(self.snp.width).multipliedBy(0.18)
            make.centerX.equalTo(self.snp.centerX)
        }
        commentButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.leading.equalTo(showThreadButton.snp.trailing)
        }
        flagButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            
        }
        shareButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTextView.snp.bottom).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(numberOfLikesLabel.snp.height)
            make.width.equalTo(self.snp.width).multipliedBy(0.18)
        }
    }
}
