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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //textView - for post
    lazy var editPostTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample Post Text Here"
        Stylesheet.Objects.Textviews.Editable.style(textview: tv)
        return tv
    }()
    
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
        }
        
        savePostButton.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(trashButton.snp.centerY)
            make.trailing.equalTo(trashButton.snp.leading).offset(-5)
        }
        
        editCategoryLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.centerY.equalTo(trashButton.snp.centerY)
        }
        
        postTitleLabel.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(safeAreaLayoutGuide.snp.leading).offset(5)
            make.top.equalTo(trashButton.snp.bottom).offset(5)
            make.trailing.equalTo(self.snp.trailing).offset(-5)
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

