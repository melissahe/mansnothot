//
//  AllCommentsView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit
import TableFlip
import Kingfisher


class AllCommentsView: UIView {

    //TODO: set up
    //add objects
    
    //textfield that will present AddCommentVC when clicked
    lazy var commentTextField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        tField.textAlignment = .center
        tField.placeholder = "Add Comment"
        // This will let you pick the color of the placeholder text
        tField.attributedPlaceholder = NSAttributedString(string: "Add Comment", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
        tField.keyboardType = .default
        tField.keyboardAppearance = .dark
        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
        tField.textColor = .white
        return tField
    }()
    
    //add tableView, registered to AllCommentsTableViewCell
    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(AllCommentsTableViewCell.self, forCellReuseIdentifier: "AllCommentsCell")
        tv.backgroundColor = .clear
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
        self.addSubview(commentTextField)
        self.addSubview(tableView)
        
        commentTextField.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.08)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing)
            make.bottom.equalTo(commentTextField.snp.top)
        }
    }

}
