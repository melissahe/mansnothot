//
//  FullSizeView.swift
//  mansnothot
//
//  Created by C4Q on 2/8/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class FullSizeView: UIView {
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: self.frame)
        scrollView.bounces = true
        scrollView.canCancelContentTouches = true
        scrollView.alwaysBounceHorizontal = true
        scrollView.alwaysBounceVertical = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.maximumZoomScale = 2.0
        scrollView.contentSize = CGSize(width: self.frame.width, height: self.frame.height)
        return scrollView
    }()
    
    lazy var scrollContentView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
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
        setUpViews()
    }
    
    private func setUpViews() {
        self.addSubview(scrollView)
        scrollView.addSubview(scrollContentView)
        scrollContentView.addSubview(profileImageView)
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        scrollContentView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollView)
            make.center.equalTo(scrollView.center)
        }
        profileImageView.snp.makeConstraints { (make) in
            make.edges.equalTo(scrollContentView)
        }
    }
}
