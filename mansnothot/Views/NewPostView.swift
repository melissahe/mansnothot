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
    
    private let imagePickerViewController = UIImagePickerController()
    
    //ImageView for picking an Image
    lazy var pickImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        Stylesheet.Objects.ImageViews.Opaque.style(imageView: imageView)
        imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
        imageView.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
        return imageView
    }()
    
    //Label for Adding an Image
    lazy var addAnImageLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Add An Image:"
        Stylesheet.Objects.Labels.PostUsername.style(label: lb)
        lb.isHidden = false // using plus sign instead
        return lb
    }()
                                                    
    //Button that goes directly over addAnImage Label
    lazy var plusSignButton: UIButton = {
        let plusSign = UIButton()
        plusSign.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        Stylesheet.Objects.Buttons.ClearButton.style(button: plusSign)
        return plusSign
    }()
    
    //titleTextField for title
    lazy var titleTextField: UITextField = {
        let tField = UITextField()
        tField.placeholder = "Enter Title of Post"
        Stylesheet.Objects.Textfields.PostTitle.style(textfield: tField)
        return tField
    }()
    
    //postTextView for PostText
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Enter Post Text Here"
        Stylesheet.Objects.Textviews.Editable.style(textview: tv)
        tv.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        return tv
    }()
    
    //Label for Category
    lazy var categoryLabel: UILabel = {
        let lb = UILabel()
        lb.text = "Category:"
        Stylesheet.Objects.Labels.PostUsername.style(label: lb)
        return lb
    }()
    
    //Button for Category
    lazy var categoryButton: UIButton = {
        let button = UIButton()
        button.setTitle("Pick a Category", for: .normal)
        Stylesheet.Objects.Buttons.CreateButton.style(button: button)
        return button
    }()
    
    //Tableview for Categories
    //Starts off hidden. When the category button is clicked it appears. Clicking on any cell makes it disappear again and change the Button Title to the selected cell's text
    lazy var tableView: UITableView = {
        let tv = UITableView()
        //create and register a cell
        tv.register(CategoryTableViewCell.self, forCellReuseIdentifier: "CategoryCell")
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
        backgroundColor = Stylesheet.Colors.RedBg
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pickImageView.layer.masksToBounds = true
    }
    
    private func setupViews() {
        //set up constraints IN ORDER
        self.addSubview(titleTextField)
        self.addSubview(categoryLabel)
        self.addSubview(categoryButton)
        self.addSubview(pickImageView)
        self.addSubview(addAnImageLabel)
        self.addSubview(postTextView)
        self.addSubview(plusSignButton)
        self.addSubview(tableView)
        
        titleTextField.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.height.equalTo(Stylesheet.ConstraintSizes.TextfieldHeight)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
        }
        
        categoryLabel.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(titleTextField.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.width.equalTo(self.safeAreaLayoutGuide.snp.width).multipliedBy(0.25)
        }
        
        categoryButton.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(categoryLabel.snp.top)
            make.leading.equalTo(categoryLabel.snp.trailing).offset(8)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
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
            make.leading.equalTo(categoryButton.snp.leading)
            make.trailing.equalTo(categoryButton.snp.trailing)
            make.height.equalTo(self.safeAreaLayoutGuide.snp.height).multipliedBy(0.25)
        }
        
        plusSignButton.snp.makeConstraints { (make) in
            make.center.equalTo(pickImageView.snp.center)
            make.edges.equalTo(pickImageView)
        }
        
        addAnImageLabel.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(pickImageView.snp.centerY)
            make.leading.equalTo(categoryLabel.snp.leading)
        }
        
        
        postTextView.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(pickImageView.snp.bottom).offset(8)
            make.leading.equalTo(self.safeAreaLayoutGuide.snp.leading).offset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide.snp.trailing).offset(-10)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-10)
        }
    }
}
