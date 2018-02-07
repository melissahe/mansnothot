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

    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category"
        Stylesheet.Objects.Labels.PostCategory.style(label: lb)
//        lb.backgroundColor = .green
//        lb.textAlignment = .left
//        lb.textColor = .black
//        lb.numberOfLines = 0
//        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    
    lazy var postTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Post Title"
        lb.backgroundColor = .green
        lb.textAlignment = .left
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    //buttons save edit and delete
    lazy var editButton: UIButton = {
        let eb = UIButton()
        eb.setImage(UIImage(named: "edit"), for: .normal)
        return eb
    }()
    
    lazy var trashButton: UIButton = {
        let tb = UIButton()
        tb.setImage(UIImage(named: "trash"), for: .normal)
        return tb
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
        super.init(style: style, reuseIdentifier: "MyPostCell")
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    
    
    
    private func commonInit() {
        backgroundColor = .white
        contentView.layer.borderColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00).cgColor
        contentView.layer.backgroundColor = UIColor(red: 0.2343, green: 0.56, blue: 0.344, alpha: 1.00).cgColor
        contentView.layer.borderWidth = 2
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        self.addSubview(categoryLabel)
        self.addSubview(postTitleLabel)
        self.addSubview(trashButton)
        self.addSubview(editButton)
        self.addSubview(postImageView)
        self.addSubview(postTextView)
        self.addSubview(thumbsUpButton)
        self.addSubview(numberOfLikesLabel)
        self.addSubview(thumbsDownButton)
        self.addSubview(numberOfDislikesLabel)
        self.addSubview(showThreadButton)
        self.addSubview(commentButton)
        self.addSubview(shareButton)
        
       
        categoryLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(5)
            make.leading.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        postTitleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide).offset(5)
            make.top.equalTo(categoryLabel.snp.bottom).offset(10)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        editButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(2)
            make.trailing.equalTo(trashButton.snp.leading).offset(-5)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.10)
//           make.width
        }
        trashButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(2)
            make.trailing.equalTo(safeAreaLayoutGuide).offset(-5)
            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.10)
        }
        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.5)
            make.height.equalTo(self.snp.height).multipliedBy(0.3)
            //make.height.equalTo(self.snp.height).multipliedBy(0.16)
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
        shareButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTextView.snp.bottom).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(numberOfLikesLabel.snp.height)
            make.width.equalTo(self.snp.width).multipliedBy(0.18)
        }
    }
}
