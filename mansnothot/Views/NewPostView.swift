//
//  NewPostView.swift
//  mansnothot
//
//  Created by C4Q on 1/30/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import UIKit
import SnapKit

class NewPostView: UIView {
    
    //TODO: set up
    //all objects
    
    //ImageView for picking an Image
    lazy var pickImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        return imageView
    }()
    
    //Label for Adding an Image
    lazy var addAnImageLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add An Image"
        lb.textColor = .black
        lb.backgroundColor = .white
        lb.textAlignment = .center
        lb.alpha = 0.50
        lb.numberOfLines = 0
        return lb
    }()
    
    //titleTextField for title
    lazy var titleTextField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 20, weight: .light)
        tField.textAlignment = .center
        tField.placeholder = "Enter Title of Post"
        // This will let you pick the color of the placeholder text
        tField.attributedPlaceholder = NSAttributedString(string: "Enter Title of Post", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
        tField.keyboardType = .default
        tField.keyboardAppearance = .dark
        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
        //tField.borderStyle = .bezel
        tField.textColor = .white
        return tField
    }()
    
    //postTextView for PostText
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.text = "Enter Post Text Here"
        tv.backgroundColor = .yellow
        tv.textAlignment = .justified
        return tv
    }()
    
    //Label for Category
    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category:"
        lb.backgroundColor = .gray
        lb.textAlignment = .center
        lb.backgroundColor = .white
        return lb
    }()
    
    
    //Button for Category
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.black, for: .normal)
        button.setTitle("Pick a Category", for: .normal)
        button.backgroundColor = .yellow
        button.layer.borderWidth = 0.5
        return button
    }()
    
    
    //Tableview for Categories
    //Starts off hidden. When the category button is clicked it appears. Clicking on any cell makes it dissapear again and change the Button Title to the selected cell's text
    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
        tv.backgroundColor = .black
        tv.backgroundColor = .clear
        tv.isHidden = true
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
        //set up constraints IN ORDER
        self.addSubview(titleTextField)
        self.addSubview(categoryLabel)
        self.addSubview(categoryButton)
        self.addSubview(pickImageView)
        self.addSubview(addAnImageLabel)
        self.addSubview(postTextView)
        self.addSubview(tableView)
        
        titleTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
        categoryLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.3)
        }
        
        categoryButton.snp.makeConstraints { (make) -> Void in
            make.leading.equalTo(categoryLabel.snp.trailing).offset(8)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.top.equalTo(categoryLabel.snp.top)
            make.height.equalTo(categoryLabel.snp.height)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(categoryButton.snp.bottom)
            make.leading.equalTo(categoryButton.snp.leading)
            make.trailing.equalTo(categoryButton.snp.trailing)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
        pickImageView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(categoryLabel.snp.bottom).offset(8)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            make.height.width.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
        }
        
        addAnImageLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(pickImageView.snp.bottom).offset(-2)
            make.leading.equalTo(pickImageView.snp.leading)
            make.trailing.equalTo(pickImageView.snp.trailing)
            make.centerX.equalTo(self.safeAreaLayoutGuide.snp.centerX)
            
        }
        
        postTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(addAnImageLabel.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
        
    }

}
