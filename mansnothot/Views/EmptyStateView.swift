//
//  EmptyStateView.swift
//  mansnothot
//
//  Created by Richard Crichlow on 2/8/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class EmptyStateView: UIView {
    
    lazy var emptyLabel: UILabel = {
        let label = UILabel()
        Stylesheet.Objects.Labels.Regular.style(label: label)
        label.font = UIFont(name: "Helvetica Neue", size: 20.0)
        return label
    }()
    
    init(emptyText: String) {
        super.init(frame: UIScreen.main.bounds)
        self.emptyLabel.text = emptyText
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setUpViews()
    }
    
    private func setUpViews() {
        self.addSubview(emptyLabel)
        
        emptyLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
}
