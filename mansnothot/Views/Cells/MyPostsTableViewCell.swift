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

class MyPostsTableViewCell: UITableViewCell {

    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category"
        Stylesheet.Objects.Labels.PostCategory.style(label: lb)
        return lb
    }()
    
    lazy var postTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Post Title"
        Stylesheet.Objects.Labels.PostTitle.style(label: lb)
        return lb
    }()
    
    //buttons save edit and delete
    lazy var editButton: UIButton = {
        let eb = UIButton()
        eb.setImage(UIImage(named: "edit"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: eb)
        return eb
    }()
    
    lazy var trashButton: UIButton = {
        let tb = UIButton()
        tb.setImage(UIImage(named: "trash"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: tb)
        return tb
    }()
    
    //postImageView - image view in post
    lazy var postImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: imageView)
        imageView.clipsToBounds = true
        return imageView
    }()
    
    //textView - for post
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Post Text Here"
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
    
    //comment icon button
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
   
    //Share Button
    lazy var shareButton: UIButton = {
        let button = UIButton()
        button.setTitle("Share", for: .normal)
        Stylesheet.Objects.Buttons.Link.style(button: button)
        return button
    }()
    
    // share arrow button
    lazy var showArrowButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "sharearrow"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "MyPostCell")
        commonInit()
    }
    
    public func configureCell(withPost post: Post) {
        self.categoryLabel.text = post.category
        self.numberOfDislikesLabel.text = "-" + post.numberOfDislikes.description
        self.numberOfLikesLabel.text = "+" + post.numberOfLikes.description
        self.postTitleLabel.text = post.title
        self.postTextView.text = post.bodyText
        
        self.postImageView.image = nil
        if let imageURLString = post.imageURL, let imageURL = URL(string: imageURLString) {
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        self.layer.masksToBounds = true
        self.layer.borderWidth = 1
        self.layer.borderColor = Stylesheet.Colors.LightGrey.cgColor
        backgroundColor = .white
        contentView.layer.borderColor = Stylesheet.Colors.LightGrey.cgColor
        contentView.layer.borderWidth = 1
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
        self.addSubview(showArrowButton)
        
        categoryLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(15)
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(5)
        }
        
        postTitleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.top.equalTo(trashButton.snp.bottom).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        editButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.trailing.equalTo(trashButton.snp.leading).offset(-5)
        }
        trashButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(categoryLabel.snp.centerY)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.leading.equalTo(self.snp.leading)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(self.snp.width)
        }
        postTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.leading.equalTo(self.snp.leading).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        thumbsUpButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(showThreadButton.snp.centerY)
            make.leading.equalTo(self.snp.leading).offset(5)
        }
        numberOfLikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsUpButton.snp.trailing).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
        thumbsDownButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(numberOfLikesLabel.snp.trailing).offset(2)
            make.centerY.equalTo(showThreadButton.snp.centerY)
        }
        numberOfDislikesLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(thumbsDownButton.snp.trailing).offset(2)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.height.equalTo(self.snp.width).multipliedBy(0.07)
        }
        showThreadButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(commentButton.snp.centerY)
            make.leading.equalTo(commentButton.snp.trailing).offset(2)
        }
        commentButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            make.centerX.equalTo(self.snp.centerX)
        }
        showArrowButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTextView.snp.bottom).offset(5)
            make.trailing.equalTo(shareButton.snp.leading).offset(-2)
            make.bottom.equalTo(self.snp.bottom).offset(-5)
            
        }
        shareButton.snp.makeConstraints { (make) -> Void in
            make.trailing.equalTo(self.snp.trailing).offset(-5)
            make.centerY.equalTo(commentButton.snp.centerY)
        }
    }
}
