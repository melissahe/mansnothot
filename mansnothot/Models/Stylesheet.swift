//
//  Stylesheet.swift
//  mansnothot
//
//  Created by Richard Crichlow on 2/6/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import UIKit

enum Stylesheet {
    
    enum Colors {
        static let White = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
        static let LightGrey = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.00)
        static let Red = UIColor(red: 0.949, green: 0.141, blue: 0, alpha: 1.0)
        static let Orange = UIColor(red: 0.925, green: 0.471, blue: 0.235, alpha: 1.00)
        static let Yellow = UIColor(red: 0.9569, green: 0.8627, blue: 0, alpha: 1.0)
        static let Dark = UIColor(red: 0.184, green: 0.157, blue: 0.118, alpha: 1.00)
    }
    
    enum Fonts {
        static let AppName = UIFont(name: "Optima", size: 50.0)
        static let PostTitle = UIFont(name: "Optima", size: 20.0)
        static let Regular = UIFont(name: "Helvetica Neue", size: 15.0)
        static let Login = UIFont(name: "Helvetica Neue", size: 15.0)
        static let Link = UIFont(name: "Helvetica Neue", size: 15.0)
        static let Bold = UIFont(name: "Helvetica Bold", size: 15.0)
    }
    
    enum BorderWidths {
        static let Textviews = 0.5
        static let TextfieldEditable = 1
        static let TextfieldCompleted = 0
        static let PostImages = 0.5
        static let UserImages = 0.5
        static let FunctionButtons = 0.5
        static let Buttons = 1
    }
    
    enum ConstraintSizes {
        static let ButtonWidthMult = 0.6
        static let ButtonHeightMult = 0.04
        static let TextfieldWidthMult = 0.8
        static let TextfieldHeight = 40
    }
}

extension Stylesheet {
    
    enum Objects {
        
        enum ImageViews {
            case Clear
            case Opaque
            
            func style(imageView: UIImageView) {
                switch self {
                case .Clear:
//                    imageView.backgroundColor = .clear
                    imageView.backgroundColor = .yellow
                    imageView.contentMode = .scaleAspectFit
                    imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
                    imageView.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
                case .Opaque:
//                    imageView.backgroundColor = .white
                    imageView.backgroundColor = .red
                    imageView.contentMode = .scaleAspectFill
                    imageView.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.FunctionButtons)
                    imageView.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
                }
            }
        }
        
        enum Buttons {
            case Login
            case Link
            case CreateButton
            case ClearButton
            
            func style(button: UIButton) {
                switch self {
                case .Login:
                    button.setTitle("Log In", for: .normal)
                    button.setTitleColor(Stylesheet.Colors.LightGrey, for: .normal)
                    button.showsTouchWhenHighlighted = true
                    button.titleLabel?.font = Stylesheet.Fonts.Bold
                    button.backgroundColor = Stylesheet.Colors.Red
                    button.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
                    button.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.Buttons)
                case .Link:
                    //                    button.backgroundColor = .clear
                    button.backgroundColor = .yellow
                    button.setTitleColor(Stylesheet.Colors.Orange, for: .normal)
                    button.showsTouchWhenHighlighted = true
                    button.titleLabel?.font = Stylesheet.Fonts.Link
                case .CreateButton:
                    button.setTitleColor(Stylesheet.Colors.Red, for: .normal)
                    button.showsTouchWhenHighlighted = true
                    button.titleLabel?.font = Stylesheet.Fonts.Bold
                    button.backgroundColor = Stylesheet.Colors.Yellow
                    button.layer.borderColor = (Stylesheet.Colors.Orange).cgColor
                    button.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.Buttons)
                case .ClearButton:
//                    button.backgroundColor = .clear
                    button.backgroundColor = .green

                    button.contentMode = .scaleAspectFit
                    button.tintColor = Stylesheet.Colors.Orange
                }
            }
        }
        
        enum Labels {
            case Regular
            case AppName
            case PostCategory
            case PostTitle
            case PostUsername
            case LikesDislikes
            
            func style(label: UILabel) {
                switch self {
                case .Regular:
                    label.font = Stylesheet.Fonts.Regular
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .left
                case .AppName:
                    label.font = Stylesheet.Fonts.AppName
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .center
                case .PostCategory:
                    label.font = Stylesheet.Fonts.Bold
                    label.textColor = Stylesheet.Colors.Red
                    label.backgroundColor = .clear
                    label.textAlignment = .left
                case .PostTitle:
                    label.font = Stylesheet.Fonts.PostTitle
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .left
                case .PostUsername:
                    label.font = Stylesheet.Fonts.Regular
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .left
                case .LikesDislikes:
                    label.font = Stylesheet.Fonts.Link
                    label.textColor = Stylesheet.Colors.Dark
                    label.backgroundColor = .clear
                    label.textAlignment = .center
                }
            }
        }
        enum Textviews {
            case Completed
            case Editable
            
            func style(textview: UITextView) {
                switch self {
                case .Completed:
                    textview.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.TextfieldCompleted)
                    textview.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textview.backgroundColor = Stylesheet.Colors.White
                    textview.textAlignment = .natural
                    textview.isEditable = false
                    textview.textColor = Stylesheet.Colors.Dark
                    textview.font = Stylesheet.Fonts.Regular
                    textview.adjustsFontForContentSizeCategory = true
                    
                case .Editable:
                    textview.layer.borderWidth = CGFloat(Stylesheet.BorderWidths.TextfieldEditable)
                    textview.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textview.backgroundColor = Stylesheet.Colors.White
                    textview.textAlignment = .natural
                    textview.isEditable = true
                    textview.textColor = Stylesheet.Colors.Dark
                    textview.font = Stylesheet.Fonts.Regular
                    textview.adjustsFontForContentSizeCategory = true
                }
            }
        }
        

        
        enum Textfields {
            case UserName
            case LoginEmail
            case LoginPassword
            case PostTitle
            
            func style(textfield: UITextField) {
                switch self {
                case .UserName:
                    textfield.borderStyle = UITextBorderStyle.bezel
                    textfield.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textfield.backgroundColor = Stylesheet.Colors.White
                    textfield.textAlignment = NSTextAlignment.left
                    textfield.font = Stylesheet.Fonts.Login
                    textfield.textColor = Stylesheet.Colors.Dark
                    textfield.adjustsFontSizeToFitWidth = true
                    textfield.autocapitalizationType = .words
                    textfield.autocorrectionType = .no
                    textfield.keyboardType = .asciiCapable
                    textfield.returnKeyType = .default
                    textfield.placeholder = "User Name"
                case .LoginEmail:
                    textfield.borderStyle = UITextBorderStyle.bezel
                    textfield.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textfield.backgroundColor = Stylesheet.Colors.White
                    textfield.textAlignment = NSTextAlignment.left
                    textfield.font = Stylesheet.Fonts.Login
                    textfield.textColor = Stylesheet.Colors.Dark
                    textfield.adjustsFontSizeToFitWidth = true
                    textfield.autocapitalizationType = .none
                    textfield.autocorrectionType = .no
                    textfield.keyboardType = .emailAddress
                    textfield.returnKeyType = .default
                    textfield.placeholder = "Email Address"
                case .LoginPassword:
                    textfield.borderStyle = UITextBorderStyle.bezel
                    textfield.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textfield.backgroundColor = Stylesheet.Colors.White
                    textfield.textAlignment = NSTextAlignment.left
                    textfield.font = Stylesheet.Fonts.Login
                    textfield.textColor = Stylesheet.Colors.Dark
                    textfield.adjustsFontSizeToFitWidth = true
                    textfield.autocapitalizationType = .none
                    textfield.autocorrectionType = .no
                    textfield.keyboardType = .asciiCapable
                    textfield.returnKeyType = .default
                    textfield.placeholder = "Password"
                    textfield.isSecureTextEntry = true
                case .PostTitle:
                    textfield.borderStyle = UITextBorderStyle.bezel
                    textfield.layer.borderColor = (Stylesheet.Colors.LightGrey).cgColor
                    textfield.backgroundColor = Stylesheet.Colors.White
                    textfield.textAlignment = NSTextAlignment.left
                    textfield.font = Stylesheet.Fonts.Regular
                    textfield.textColor = Stylesheet.Colors.Dark
                    textfield.adjustsFontSizeToFitWidth = true
                    textfield.autocapitalizationType = .sentences
                    textfield.autocorrectionType = .yes
                    textfield.keyboardType = .asciiCapable
                    textfield.returnKeyType = .next
                    textfield.placeholder = "Post Title"
                }
            }
        }
        
    }
}

