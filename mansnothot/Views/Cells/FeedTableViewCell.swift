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
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: imageView)
        imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
        return imageView
    }()
    
    //categoryLabel - for Post Category
    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        Stylesheet.Objects.Labels.PostCategory.style(label: lb)
        return lb
    }()
    
    //usernameLabel - for user name
    lazy var usernameLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        Stylesheet.Objects.Labels.PostUsername.style(label: lb)
        return lb
    }()
    
    //postTitleLabel - for user name
    lazy var postTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = ""
        Stylesheet.Objects.Labels.PostTitle.style(label: lb)
        return lb
    }()
    
    //postImageView - image view in post
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: imageView)
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    //textView - for post
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.text = ""
        Stylesheet.Objects.Textviews.Completed.style(textview: tv)
        return tv
    }()
    
    //thumbsUp button - adds to likes
    lazy var thumbsUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "thumbsUp"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: button)
        return button
    }()
    
    //numberOfLikes label - number of likes
    lazy var numberOfLikesLabel: UILabel = {
        let lb = UILabel()
        lb.text = "+37"
        Stylesheet.Objects.Labels.LikesDislikes.style(label: lb)
        return lb
    }()
    
    //thumbsDown button - adds to dislikes
    lazy var thumbsDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "thumbsDown"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: button)
        return button
    }()
    
    //numberOfDislikes label - number of dislikes
    lazy var numberOfDislikesLabel: UILabel = {
        let lb = UILabel()
        lb.text = "-7"
        Stylesheet.Objects.Labels.LikesDislikes.style(label: lb)
        return lb
    }()
    
    lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "comment"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: button)
        return button
    }()
    
    //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
    lazy var showThreadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Thread", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: button)
        return button
    }()
    
    //flag icon (which is a button) - that will present the flag action sheet
    lazy var flagButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "flagclear"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: button)
        return button
    }()
    
    //Share Button
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: button)
        return button
    }()
    
    lazy var showArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sharearrow"), for: .normal)
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
        super.layoutSubviews()
        backgroundColor = .white
        contentView.layer.borderColor = Stylesheet.Colors.LightGrey.cgColor
        contentView.layer.borderWidth = 3
        setupAndConstrainObjects()
        
        // To add round edges
        userImageView.layer.cornerRadius = userImageView.bounds.height / 2
        userImageView.layer.masksToBounds = true
    }
    
    public func configureCell(withPost post: Post) {
        self.categoryLabel.text = "This is \(post.category)"
        self.postTitleLabel.text = post.title
        self.numberOfLikesLabel.text = "+" +  post.numberOfLikes.description
        self.numberOfDislikesLabel.text = "-" +  post.numberOfDislikes.description
        
        if let postText = post.bodyText, !postText.isEmpty {
            self.postTextView.text = postText
        } else {
            self.postTextView.text = nil
        }
        
        self.userImageView.image = nil
        DatabaseService.manager.getUserProfile(withUID: post.userID) { (userProfile) in
            self.usernameLabel.text = userProfile.displayName
            
            ImageCache(name: post.userID).retrieveImage(forKey: post.userID, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    self.userImageView.image = image
                    self.layoutIfNeeded()
                } else {
                    guard let userUrlString = userProfile.imageURL, let url = URL(string: userUrlString) else {
                        self.userImageView.image = #imageLiteral(resourceName: "placeholder-image")
                        self.layoutIfNeeded()
                        return
                    }
                    self.userImageView.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let image = image {
                            ImageCache(name: post.userID).store(image, forKey: post.userID)
                        }
                        if let error = error {
                            print(error)
                        }
                        self.layoutIfNeeded()
                    })
                }
            })
        }
        
        self.postImageView.image = nil

        if let postURLString = post.imageURL, let imageURL = URL(string: postURLString) {
            ImageCache(name: post.postID).retrieveImage(forKey: post.postID, options: nil, completionHandler: { (image, _) in
                if let image = image {
                    self.postImageView.image = image
                    self.layoutIfNeeded()
                } else {
                    self.postImageView.kf.setImage(with: imageURL, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: { (image, error, _, _) in
                        if let image = image {
                            ImageCache(name: post.postID).store(image, forKey: post.postID)
                            self.layoutIfNeeded()
                        }
                    })
                }
            })
        } else {
            self.postImageView.image = #imageLiteral(resourceName: "placeholder-image")
            self.layoutIfNeeded()
        }
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
        self.addSubview(showArrowButton)
        
        userImageView.snp.makeConstraints { (make) -> Void in
            make.height.width.equalTo(self.snp.width).multipliedBy(0.09).priority(999)
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
        postTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX).priority(999)
            make.bottom.equalTo(postTextView.snp.top).offset(-5)
                        make.height.equalTo(self.snp.width)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
        }
        showThreadButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(commentButton.snp.centerY)
            make.leading.equalTo(commentButton.snp.trailing).offset(2)
        }
        thumbsUpButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(showThreadButton.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
        numberOfLikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsUpButton.snp.trailing).offset(2).priority(999)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
        thumbsDownButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(numberOfLikesLabel.snp.trailing).offset(2)
            make.centerY.equalTo(showThreadButton.snp.centerY)
        }
        numberOfDislikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsDownButton.snp.trailing).offset(2).priority(998)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
        commentButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.centerX.equalTo(self.snp.centerX)
        }
        flagButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            
        }
        showArrowButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTextView.snp.bottom).offset(5).priority(999)
            make.trailing.equalTo(shareButton.snp.leading).offset(-2)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            
        }
        shareButton.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.centerY.equalTo(commentButton.snp.centerY)
        }
    }
}
