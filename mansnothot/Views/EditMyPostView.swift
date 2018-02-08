//
//  EditMyPostView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit


class EditMyPostView: UIView {

    lazy var editCategoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category"
        Stylesheet.Objects.Labels.PostCategory.style(label: lb)
//        lb.backgroundColor = .green
//        lb.textAlignment = .left
//        lb.textColor = .black
//        lb.numberOfLines = 0
//        lb.layer.borderWidth = 0.5
//        lb.textAlignment = .center
        return lb
    }()
    
    lazy var savePostButton: UIButton = {
        let spb = UIButton()
        spb.setImage(UIImage(named: "save"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: spb)
        return spb
    }()

    lazy var postTitleLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Post Title"
        Stylesheet.Objects.Labels.PostTitle.style(label: lb)
//        lb.backgroundColor = .green
//        lb.textAlignment = .left
//        lb.textColor = .black
//        lb.numberOfLines = 0
//        lb.layer.borderWidth = 0.5
//        lb.textAlignment = .center
        return lb
    }()
    
    //buttons save edit and delete
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
//        imageView.backgroundColor = .green
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    //textView - for post
    lazy var editPostTextView: UITextView = {
        let tv = UITextView()
        Stylesheet.Objects.Textviews.Editable.style(textview: tv)
        tv.text = "Sample Post Text Here"
//        tv.layer.borderWidth = 0.5
//        tv.backgroundColor = .yellow
//        tv.textAlignment = .justified
//        tv.isEditable = false
        return tv
    }()
    
//    //thumbsUp button - adds to likes
//    lazy var thumbsUpButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "thumbsUp"), for: .normal)
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 0.5
//        return button
//    }()
//
//    //numberOfLikes label - number of likes
//    lazy var numberOfLikesLabel: UILabel = {
//        let lb = UILabel()
//        lb.text = "+37"
//        lb.backgroundColor = .gray
//        lb.textAlignment = .center
//        lb.backgroundColor = .white
//        return lb
//    }()
//
//    //thumbsDown button - adds to dislikes
//    lazy var thumbsDownButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "thumbsDown"), for: .normal)
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 0.5
//        return button
//    }()
//
//    //numberOfDislikes label - number of dislikes
//    lazy var numberOfDislikesLabel: UILabel = {
//        let lb = UILabel()
//        lb.text = "-7"
//        lb.backgroundColor = .gray
//        lb.textAlignment = .center
//        lb.backgroundColor = .white
//        return lb
//    }()
//
//
//    //comment button - should segue to AddCommentVC //actually i'm not sure if we're doing this anymore, refer to trello!
//    lazy var commentButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(named: "comment"), for: .normal)
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 0.5
//        return button
//    }()
    
//    //showThread button - should display the total number of comments in button title - should segue to AllCommentsVC
//    lazy var showThreadButton: UIButton = {
//        let button = UIButton()
//        button.setTitleColor(.black, for: .normal)
//        button.setTitle("Thread", for: .normal)
//        button.backgroundColor = .orange
//        button.layer.borderWidth = 0.5
//
//        return button
//    }()
//
//
//    //Share Button
//    lazy var shareButton: UIButton = {
//        let button = UIButton()
//        button.setTitleColor(.black, for: .normal)
//        button.setTitle("Share", for: .normal)
//        button.backgroundColor = .yellow
//        button.layer.borderWidth = 0.5
//        return button
//    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
    private func commonInit() {
        backgroundColor = .white
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects() {
        self.addSubview(trashButton)
        self.addSubview(savePostButton)
        self.addSubview(editCategoryLabel)
        self.addSubview(postTitleLabel)
        self.addSubview(postImageView)
        self.addSubview(editPostTextView)
        
        trashButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(5)
            make.trailing.equalTo(safeAreaLayoutGuide.snp.trailing).offset(-5)
            //            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.10)
        }
        
        savePostButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(trashButton.snp.centerY)
            make.trailing.equalTo(trashButton.snp.leading).offset(-5)
            //            make.height.equalTo(safeAreaLayoutGuide.snp.height).multipliedBy(0.10)
            //           make.width
        }
        
        editCategoryLabel.snp.makeConstraints { (make) -> Void in
//            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(5)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalTo(trashButton.snp.centerY)
//            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
//            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.07)
        }
        
        postTitleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(5)
            make.top.equalTo(trashButton.snp.bottom).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
//            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.07)
        }

        postImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(postTitleLabel.snp.bottom).offset(5)
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(postTitleLabel.snp.width)
            make.height.equalTo(postTitleLabel.snp.width).multipliedBy(0.4)
        }
        editPostTextView.snp.makeConstraints { (make) -> Void in
            make.centerX.equalTo(self.snp.centerX)
            make.width.equalTo(self.snp.width).multipliedBy(0.9)
            make.top.equalTo(postImageView.snp.bottom).offset(5)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}



//savePostButton.snp.makeConstraints { (make) -> Void in
//make.top.equalTo(self.snp.top).offset(2)
//make.leading.equalTo(categoryLabel.snp.trailing).offset(65)
//
//}




