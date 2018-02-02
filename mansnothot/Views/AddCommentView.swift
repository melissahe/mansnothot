//
//  AddCommentView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//TODO: set up
    //add objects

class AddCommentView: UIView {

    //postTextView for PostText
    lazy var postCommentTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.text = "Enter Post Text Here"
        tv.backgroundColor = .yellow
        tv.textAlignment = .justified
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
        setupViews()
    }
    
    private func setupViews() {
        self.addSubview(postCommentTextView)
        
        postCommentTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.5)
        }
        
    }

}
