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
}

extension Stylesheet {
    
    enum Objects {
        
        
        enum Buttons {
            case Login
            case ChangeLink
            case CreateLink
            
            func style(button: UIButton) {
                switch self {
                case .Login:
                    button.setTitle("Log In", for: .normal)
                    button.setTitleColor(Stylesheet.Colors.LightGrey, for: .normal)
                    button.showsTouchWhenHighlighted = true
                    button.titleLabel?.font = Stylesheet.Fonts.Bold
                    button.backgroundColor = Stylesheet.Colors.Red
//                    button.layer.shadowOffset = CGSize(width: 1, height: 1)
//                    button.layer.shadowRadius = 0.25
//                    button.layer.shadowColor = (Stylesheet.Colors.Dark).cgColor
//                    button.layer.shadowOpacity = 0.5
                    button.layer.borderColor = (Stylesheet.Colors.Dark).cgColor
                    button.layer.borderWidth = 1
//                    button.layer.masksToBounds = true
                case .ChangeLink:
                    button.setTitleColor(Stylesheet.Colors.Orange, for: .normal)
                    button.showsTouchWhenHighlighted = true
                    button.titleLabel?.font = Stylesheet.Fonts.Link
//                    button.layer.shadowOffset = CGSize(width: 1, height: 1)
//                    button.layer.shadowRadius = 0.25
//                    button.layer.shadowColor = (Stylesheet.Colors.Dark).cgColor
//                    button.layer.shadowOpacity = 0.5
                case .CreateLink:
                    button.setTitleColor(Stylesheet.Colors.Red, for: .normal)
                    button.showsTouchWhenHighlighted = true
                    button.titleLabel?.font = Stylesheet.Fonts.Bold
                    button.backgroundColor = Stylesheet.Colors.Yellow
                    button.layer.borderColor = (Stylesheet.Colors.Orange).cgColor
                    button.layer.borderWidth = 1
//                    button.layer.shadowOffset = CGSize(width: 1, height: 1)
//                    button.layer.shadowRadius = 0.25
//                    button.layer.shadowColor = (Stylesheet.Colors.Dark).cgColor
//                    button.layer.shadowOpacity = 0.5
                }
            }
        }
        
        enum Labels {
            case Username
            case AppName
            case Category
            case PostTitle
            
            func style(label: UILabel) {
                switch self {
                case .Username:
                    label.textColor = Stylesheet.Colors.Dark
                    label.font = Stylesheet.Fonts.Regular
                case .AppName:
                    label.font = Stylesheet.Fonts.AppName
                    label.textColor = Stylesheet.Colors.Dark
                case .Category:
                    label.font = Stylesheet.Fonts.Bold
                    label.textColor = Stylesheet.Colors.Dark
                case .PostTitle:
                    label.font = Stylesheet.Fonts.PostTitle
                    label.textColor = Stylesheet.Colors.Dark
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

