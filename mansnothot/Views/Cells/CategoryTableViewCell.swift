//
//  CategoryTableViewCell.swift
//  mansnothot
//
//  Created by Richard Crichlow on 1/31/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class CategoryTableViewCell: UITableViewCell {

    //label
    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category Here"
        lb.backgroundColor = .white
        lb.textAlignment = .center
        lb.textColor = .black
        lb.numberOfLines = 0
        lb.layer.borderWidth = 0.5
        return lb
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style , reuseIdentifier: "CategoryCell")
        setupAndConstrainObjects()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupAndConstrainObjects()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupAndConstrainObjects()
    }
    
    private func setupAndConstrainObjects(){
        self.addSubview(categoryLabel)
        categoryLabel.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self.snp.edges)
        }
    }
        
}
