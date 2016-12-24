//
//  GlobalVariables.swift
//  parking-dude-ios
//
//  Created by Bahrom Abdullaev on 11/19/16.
//  Copyright © 2016 TechCells. All rights reserved.
//

import Foundation
import UIKit
//import PKHUD



let kCornerRadius = 5.0
let kPortraitHeight = UIScreen.main.bounds.height
let kPortraitWidth = UIScreen.main.bounds.width

var globalNavigationController: UINavigationController!

var hasRightMenu: Bool = false
var hasLeftMenu: Bool = false

var isPatient: Bool = true

var chatPushCount: Int = 0
var updatePushCount: Int = 0

var isIphone4: Bool{
    return kPortraitHeight <= 480
}

var isIphone5: Bool{
    return (kPortraitHeight > 480 && kPortraitHeight <= 568)
}

func quickAlertView(title text: String){    
  //  PKHUD.sharedHUD.contentView
      //  = PKHUDTextView(text: text)
    //PKHUD.sharedHUD.show()
    //PKHUD.sharedHUD.hide(afterDelay: 1.5)
}


func MB_MULTILINE_TEXTSIZE(_ text: String!, font: UIFont, maxSize:CGSize) -> CGSize{
    
    return text.characters.count > 0 ? (text as NSString).boundingRect(with: maxSize, options: [.usesLineFragmentOrigin, .usesFontLeading], attributes: [NSFontAttributeName: font], context: nil).size : CGSize()
}




/*
*  System Versioning
*/

func SYSTEM_VERSION_EQUAL_TO(version v: String) -> Bool{
    
    return (UIDevice.current.systemVersion.compare(v, options: .numeric) == .orderedSame)
}
func SYSTEM_VERSION_GREATER_THAN(version v: String) -> Bool{
    return (UIDevice.current.systemVersion.compare(v, options: .numeric) == .orderedDescending)
}
func SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(version v: String) -> Bool{
    return (UIDevice.current.systemVersion.compare(v, options: .numeric) != .orderedAscending)
}
func SYSTEM_VERSION_LESS_THAN(version v: String) -> Bool{
    return (UIDevice.current.systemVersion.compare(v, options: .numeric) == .orderedAscending)
}
func SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(version v: String) -> Bool{
    return (UIDevice.current.systemVersion.compare(v, options: .numeric) != .orderedDescending)
}



let PER_PAGE           = 10

/*
 String Constant
 */

let FIELD_STATUS                            = "Status"
let FIELD_ERROR_U                           = "Error"
let FIELD_STATUS_SUCCESS                    = "Success"
let FIELD_STATUS_ERROR                      = "Error"
let FIELD_SESSION_TOKEN                     = "SessionToken"
let FIELD_RESULT 							= "Result"
let FIELD_SESSION                           = "session"
let FIELD_USER_DATA                         = "userData"
let FIELD_USER_FULL_NAME                    = "userFullName"
let FIELD_USER_PIN                          = "userPIN"
let FIELD_USER_TIME_ZONE                    = "userTimeZone"
let FIELD_USER_DATE_FORMAT                  = "userDateFormat"
let FIELD_USER_PROFILE_PICTURE              = "userProfilePicture"
let FIELD_REGISTERED                        = "isUserRegistered"


let FIELD_USER_DEVICE_TOKEN                 = "userDeviceToken"
