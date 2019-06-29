//
//  UIConstant.swift
//  MVRCache
//
//  Created by Admin on 26/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

struct UIConstant  {
    
    static let appColor = "#FF6666"
    static let appTextColor = "#000000"
    static let navTextColor = "#FFFFFF"
    static let tagBgColor = "#9ACD32"
    static let tagTextColor = "#FFFFFF"
    
    struct ProgressHUD {
        static let bgColor = "#FFFFFF"
        static let TextColor = "#A9A9A9"
    }
    
    struct Images {
        static let searchIcon = "icon-search"
        static let noImageSmall = "no-img-small"
        static let noImageMedium = "no-img-medium"
        static let noImageLarge = "no-img-large"
        static let backIcon = "icon-back"
        static let placeHolderImage = "userplaceholder"
    }
    
    struct Fonts {
        
        static func FONT_HELVETICA_BOLD(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica-Bold", size: _size)!
            return font
        }
        
        static func FONT_HELVETICA_REGULAR(_ _size:CGFloat) -> UIFont {
            let font: UIFont = UIFont(name: "Helvetica", size: _size)!
            return font
        }
    }
}
