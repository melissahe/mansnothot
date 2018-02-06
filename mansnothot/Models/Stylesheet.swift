//
//  Stylesheet.swift
//  mansnothot
//
//  Created by Richard Crichlow on 2/6/18.
//  Copyright © 2018 Melissa He @ C4Q. All rights reserved.
//

import Foundation
import UIKit

class Stylesheet {
    
    enum Colors {
        static let White = UIColor(red: 1.000, green: 1.000, blue: 1.000, alpha: 1.00)
        static let LightGrey = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.00)
        static let Red = UIColor(red: 0.961, green: 0.961, blue: 0.961, alpha: 1.00)
        static let Orange = UIColor(red: 0.925, green: 0.471, blue: 0.235, alpha: 1.00)
        static let Yellow = UIColor(red: 0.929, green: 0.714, blue: 0.384, alpha: 1.00)
        static let Dark = UIColor(red: 0.184, green: 0.157, blue: 0.118, alpha: 1.00)
    }
    
    enum Fonts {
        static let Title = UIFont(name: "Optima", size: 50.0)
        static let Regular = UIFont(name: "Helvetica Neue", size: 10.0)
        static let Bold = UIFont(name: "Myriad", size: 25.0)
    }
    
    enum Contents {
        enum Button {
            static let FillColor = Stylesheet.Colors.Red
            static let TextColor =  Stylesheet.Colors.Yellow
            static let TextFont = Stylesheet.Fonts.Regular
        }
        
        enum Post {
            static let PostTitle = Stylesheet.Fonts.Title
            static let CategoryTitle = Stylesheet.Fonts.Bold
            static let UserNameTitle = Stylesheet.Fonts.Regular
        }
        
        enum Textfields {
            static let BorderColor = Stylesheet.Colors.LightGrey
            static let TextColor = Stylesheet.Colors.Dark
            static let BorderType = UITextBorderStyle.line
            static let TextAlignment = NSTextAlignment.left
            
        }
    }
}
