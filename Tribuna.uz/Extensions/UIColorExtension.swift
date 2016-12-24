//
//  UIColorExtension.swift
//  parking-dude-ios
//
//  Created by Bahrom Abdullaev on 11/21/16.
//  Copyright © 2016 TechCells. All rights reserved.
//

import Foundation
import UIKit


extension UIColor{

    class func colorWithRGB(r red:CGFloat, g green:CGFloat, b blue:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    
    class func colorWithRGB(r red:CGFloat, g green:CGFloat, b blue:CGFloat, a alpha:CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    class func mainBlueColor() -> UIColor{
        return self.colorWithRGB(r: 20.0, g: 105.0, b: 168.0)
    }
    
    /*
    class func mainNavBackColor() -> UIColor{
        return self.colorWithRGB(r: 20.0, g: 105.0, b: 168.0)
    }
    */
    class func mainNavBackColor() -> UIColor{
        return self.colorWithRGB(r: 21.0, g: 161.0, b: 4.0)
    }
    
    class func adminTableBackColor() -> UIColor{
        return self.colorWithRGB(r: 233.0, g: 239.0, b: 241.0)
    }
    
}
