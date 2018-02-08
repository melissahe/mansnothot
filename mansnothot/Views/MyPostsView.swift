//
//  MyPostsView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

//TODO: set up
    //add objects
        //tableview - displays all posts; registers cell with "MyPostsTableViewCell"
        //edit and delete button to be able to edit the post and/or delete
    //set up constraints

class MyPostsView: UIView {

    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(MyPostsTableViewCell.self, forCellReuseIdentifier: "MyPostCell")
        tv.allowsSelection = false 
        return tv
    }()
    

    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        setupTableView()
    }

    private func setupTableView() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(safeAreaLayoutGuide.snp.edges)
        }
    }
}
