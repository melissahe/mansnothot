//
//  HomeFeedView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit


class HomeFeedView: UIView {
    //TODO: set up
    //add objects
    
    //SegmentedControlBar
    lazy var segmentedBar: UISegmentedControl = {
        let items = ["Purple", "Blue"] // names of each segment
        let sc = UISegmentedControl(items: items)
        sc.selectedSegmentIndex = 0
        sc.layer.cornerRadius = 5.0
        sc.backgroundColor = .black
        sc.tintColor = .red
        
        return sc
        }()
    
    //tableview - register cell using FeedTableViewCell
    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(FeedTableViewCell.self, forCellReuseIdentifier: "FeedCell")
        tv.backgroundColor = .clear
        tv.isHidden = false
        return tv
    }()
    
    //flag icon should probably present action sheet for flagging

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
     
    private func commonInit() {
        backgroundColor = .clear
        setupViews()
    }
    
    private func setupViews() {
        //add subviews
        self.addSubview(segmentedBar)
        self.addSubview(tableView)
        
        //set up constraints
        segmentedBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(0)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(1)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.05)
            
        }
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(segmentedBar.snp.bottom)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width)
        }
        
    }

}
