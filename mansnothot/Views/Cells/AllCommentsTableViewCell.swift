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
        lb.text = "Username of Poster"
        Stylesheet.Objects.Labels.PostUsername.style(label: lb)
//        lb.backgroundColor = .white
//        lb.textAlignment = .center
//        lb.textColor = .black
//        lb.numberOfLines = 0
//        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    //textView - for comment
    lazy var commentTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Comment Text Here"
        Stylesheet.Objects.Textviews.Completed.style(textview: tv)
//        tv.layer.borderWidth = 0.5
//        tv.backgroundColor = .yellow
//        tv.textAlignment = .justified
//        tv.isEditable = false
//        tv.textColor = .black
        return tv
    }()
    
    //thumbsUp button - adds to likes
    lazy var thumbsUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "thumbsUp"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: button)
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 0.5
        return button
    }()
    
    //numberOfLikes label - number of likes
    lazy var numberOfLikesLabel: UILabel = {
        let lb = UILabel()
        lb.text = "9"
        Stylesheet.Objects.Labels.LikesDislikes.style(label: lb)
//        lb.backgroundColor = .gray
//        lb.textAlignment = .center
//        lb.backgroundColor = .white
        return lb
    }()
    
    //thumbsDown button - adds to dislikes
    lazy var thumbsDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "thumbsDown"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: button)
//        button.backgroundColor = .clear
//        button.layer.borderWidth = 0.5
        return button
    }()
    
    //numberOfDislikes label - number of dislikes
    lazy var numberOfDislikesLabel: UILabel = {
        let lb = UILabel()
        lb.text = "-7"
        Stylesheet.Objects.Labels.LikesDislikes.style(label: lb)
//        lb.backgroundColor = .gray
//        lb.textAlignment = .center
//        lb.backgroundColor = .white
        return lb
    }()
    
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
        backgroundColor = .white
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        self.addSubview(thumbsUpButton)
        self.addSubview(numberOfLikesLabel)
        self.addSubview(thumbsDownButton)
        self.addSubview(numberOfDislikesLabel)
        self.addSubview(usernameLabel)
        self.addSubview(commentTextView)
        
        thumbsUpButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
        }
        
        numberOfLikesLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(thumbsUpButton.snp.bottom)
            make.leading.equalTo(thumbsUpButton.snp.leading)
            make.trailing.equalTo(thumbsUpButton.snp.trailing)
            make.height.equalTo(thumbsUpButton.snp.height)
        }
        
        thumbsDownButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(numberOfLikesLabel.snp.bottom)
            make.leading.equalTo(thumbsUpButton.snp.leading)
            make.trailing.equalTo(thumbsUpButton.snp.trailing)
            make.height.equalTo(thumbsUpButton.snp.height)
        }
        
        numberOfDislikesLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(thumbsDownButton.snp.bottom)
            make.leading.equalTo(thumbsUpButton.snp.leading)
            make.trailing.equalTo(thumbsUpButton.snp.trailing)
            make.height.equalTo(thumbsUpButton.snp.height)
            make.bottom.equalTo(self.snp.bottom)
        }
        
        //Update these contraints so that the trailing is set to the leading of the buttons
        usernameLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.snp.leading).offset(5)
            make.top.equalTo(self.snp.top).offset(5)
            make.trailing.equalTo(thumbsUpButton.snp.leading).offset(-5)
        }
        
        commentTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(usernameLabel.snp.bottom)
            make.leading.equalTo(usernameLabel.snp.leading)
            make.trailing.equalTo(usernameLabel.snp.trailing)
//            make.bottom.equalTo(self.snp.bottom).offset(-5)
//            make.bottom.greaterThanOrEqualTo(numberOfDislikesLabel.snp.bottom)
        }
        
        
        
        
    }

}
