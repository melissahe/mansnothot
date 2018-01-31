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
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    //titleTextField for title
    lazy var titleTextField: UITextField = {
        let tField = UITextField()
        tField.backgroundColor = UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)
        tField.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        tField.textAlignment = .center
        tField.placeholder = "Enter Title of Post"
        // This will let you pick the color of the placeholder text
        tField.attributedPlaceholder = NSAttributedString(string: "Enter Title of Post", attributes: [NSAttributedStringKey.foregroundColor: UIColor(red: 0.918, green: 0.918, blue: 0.918, alpha: 1.00)])
        tField.keyboardType = .default
        tField.keyboardAppearance = .dark
        tField.backgroundColor = UIColor(red: 0.141, green: 0.149, blue: 0.184, alpha: 1.00)
        tField.textColor = UIColor(red: 0.000, green: 0.000, blue: 0.000, alpha: 1.00)
        tField.borderStyle = .bezel
        tField.textColor = .white
        return tField
    }()
    
    //postTextView for PostText
    lazy var postTextView: UITextView = {
        let tv = UITextView()
        tv.layer.borderWidth = 1
        tv.text = "Enter Post Text Here"
        tv.backgroundColor = .yellow
        return tv
    }()
    
    //Category Drop Down Menu for Category // so either as a table view, pickerview, or an action sheet of categories???
    
    //Consider having invisible PickerView appear when Category Button is clicked, the have it dissapear when a selection is made
    
    //Button for Category
    
    //PickerView for Categories

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
        //set up constraints
        
    }

}
