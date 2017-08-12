//
//  Constant.swift
//  iOSProject
//
//  Created by MVJadav on 12/8/16.
//  Copyright © 2016 MVJadav. All rights reserved.
//

import Foundation
import UIKit

let appDelegate = UIApplication.shared.delegate as! AppDelegate

struct AppConstant {

    static let AppName                          = "KCreation" //Need Changes App name in LauchScreen Also
    static let Rs                               = "\u{20B9}"
    static let Call                             = "\u{1F4DE}"
    static let APIKey                           = "SiteAppkey"
//    static let AppSiteSlug = "site1" //
    static let AppSiteSlug                      = "mytesting"    //MyTesting
    
    static let title                            = "User"
    
}
struct HttpParameter {
    
    ///MARK: - APIKey
//    static let APIKey = "I_d912b1c7-1e00-4c69-8ef0-c9c9103abaec"//c
    static let DeviceType = "IOS"
    static let Facebookid = "fb156089824883359"
    
    // MARK: - Constant
    static let HttpType_POST = "POST"
    static let HttpType_GET = "GET"
    
    
    // MARK: - Error Code
    
    static let Platform = "I"
}

struct Links {
    static let rateusappstorelink = "itms://itunes.apple.com/*********/**/***/**/"
}

struct AppColor {

    //App Theme Status Bar
    static let Statusbar_Primary        = UIColor(red: 105/255, green: 198/255, blue: 192/255, alpha: 0.7)
    
    //App Theme
    static let AppTheme_Primary         = UIColor(red: 105/255, green: 198/255, blue: 192/255, alpha: 1.0)
    static let AppTheme_Secondary       = UIColor(red: 255/255, green: 51/255, blue: 102/255, alpha: 0.5)
    
    static let Dark_Pink_Secondary = UIColor(red: 255/255, green: 51/255, blue: 102/255, alpha: 0.5)
    static let Dark_Blue        = UIColor(red: 62/255, green: 75/255, blue: 94/255 , alpha :1)
    static let Dark_Black       = UIColor(red: 24/255, green: 25/255, blue: 27/255 , alpha :1.0)
    static let Dark_Pink        = UIColor(red: 255/255, green: 51/255, blue: 102/255, alpha: 1.0)
    static let Dark_Green       =  UIColor(red: 68/255, green: 175/255, blue: 86/255 , alpha :1.0)
    static let Dark_Orange      =  UIColor(red: 209/255, green: 92/255, blue: 50/255, alpha: 1.0)
    static let Dark_Gray        = UIColor(red: 67/255, green: 65/255, blue: 73/255 , alpha :1)
    
    //General Light Color
    static let Light_Grey       = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 0.5)
    
    
    static let Red              = UIColor.red
    static let Green            = UIColor(red: 41/255, green: 169/255, blue: 88/255, alpha: 1.0)
    
    static let ToastGreenColor        = UIColor(red: 39/255, green: 174/255, blue: 96/255 , alpha :1)
    static let WhatsAppColor        = UIColor(red: 89/255, green: 154/255, blue: 30/255 , alpha :1)    
}

struct AppFont {
    
    //UIFont(name: "HelveticaNeue-Medium", size: 13.0)
    //Helvetica Neue Light 14.0
    static let HelveticaNeueMedium      = UIFont(name: "HelveticaNeue-Medium", size: 13.0)
    static let HelveticaNeueMedium_14      = UIFont(name: "HelveticaNeue-Medium", size: 14.0)
    
    static let HelveticaNeueLight       = UIFont(name: "HelveticaNeue-Light", size: 14.0)
    
    static let HelveticaNeue_12         = UIFont(name: "HelveticaNeue", size: 12.0)
    static let HelveticaNeue            = UIFont(name: "HelveticaNeue", size: 13.0)
    static let HelveticaNeue_18         = UIFont(name: "HelveticaNeue", size: 18.0)
    static let HelveticaNeue_14     	= UIFont(name: "HelveticaNeue", size: 14.0)
    static let HelveticaNeue_10         = UIFont(name: "HelveticaNeue", size: 10.0)
}

//MARK: App Message
struct AppMessage {

    static let deleteWarning_Goal           = "Are you sure you want to delete this User ?"
}


struct AlertTitle {
    
    //Error Title
    static let Error = "Error"
    static let Warning = "Warning"
    static let Success = "Success"
}


// MARK: - Set RequireField Alert

struct RegularExpression {
    
    /*
     // MARK: - Set RequireField Alert
     */
    let REGEX_USER_NAME_LIMIT    = "^.{3,10}$"
    static let REGEX_USER_NAME   = "^.{1,50}"
    static let REGEX_EMAIL  = "[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    static let REGEX_PASSWORD_LIMIT         = "^.{6,25}$"
    static let REGEX_PASSWORD = "[A-Za-z0-9]{6,15}"
    let REGEX_PHONE_DEFAULT = "[0-9]{3}\\-[0-9]{3}\\-[0-9]{4}"
    static let REGEX_PHONE_NUMBER = "[0-9]{15}"
    static let REGEX_Mobile_NUMBER = "[0-9+]{10,15}"
    static let REGEX_ZipCode   = "[0-9]{6}"
    static let REGEX_OTP   = "[0-9]{6}"
    static let REGEX_Amount   = "[0-9]{1,10}"
    static let REGEX_Persentage   = "[0-9]{1,2}"
    static let REGEX_Name   = "[A-Za-z]{1,30}"
    static let REGEX_PanNumber = "[A-Za-z]{5}[0-9]{4}[A-Za-z]{1}"
    static let REGEX_AadharCardNo = "^[0-9]{14}"
    let REGEX_PromoCode = "[A-Za-z0-9]{1,10}"
    let REGEX_Location   = "^.{1,150}"
    
    //static let REGEX_PRICE             = "^[0-9]+(?:\\.[0-9]{1,10})?$"
    static let REGEX_PRICE = "[0-9.]{1,10}"
}

//"Terms & Conditions"



// MARK: Date Time Formate
struct DateTimeFormate {
    
    static let Formate_yyyyMMddTHHmmssZ = "yyyy-MM-dd\'T\'HH:mm:ss Z"
    
    static let Formate_yyyyMMddHHmmssZ = "yyyy-MM-dd\' \'HH:mm:ss Z"
    
    static let Formate_yyyyMMdd = "yyyy-MM-dd"
    
    static let Formate_yyyyMMddhhmmaa = "yyyy-MM-dd hh:mm aa"
    
    static let Formate_EEEdMMMyyyyathhmmaa = "EEE d MMM, yyyy 'at' hh:mm aa"
    
    static let Formate_EEEdMMMathhmma = "EEE d MMM 'at' hh:mm a"
    
    static let Formate_MMMdathhmma = "MMM d 'at' hh:mm a"
    
    static let Formate_ddMMMathhmma = "dd MMM' at' hh:mm a"
    
    
    
    static let Formate_ddMMyyyyHHmmssZZZ = "dd-MM-yyyy HH:mm:ss ZZZ"
    
    static let Formate_ddMMMyyyyathhmma = "dd MMM, yyyy 'at' hh:mm a"
    
    static let Formate_yyyy = "yyyy"
    
    static let Formate_HHmmss = "HH:mm:ss"
    
    static let Formate_ddMMM = "dd MMM"
    
    static let Formate_hhmmaddMMMyyyy = "hh:mm a dd MMM, yyyy"
    
    static let Formate_ddMMMyyyy = "dd MMM, yyyy"
    
    static let Formate_ddMMyyyhhmmssa = "dd/MM/yyyy hh:mm:ss a" //Android users using this date time format
    
    static let Formate_ddMMyyyy = "dd/MM/yyyy"
    static let Formate_hhmmssa  = "hh:mm:ss a"
    
    static let Formate_ddMMMWithoutCommayyyy = "dd MMM yyyy"
    
    static let Formate_ddMMMWithoutCommayyyyhhmmssa = "dd MMM yyyy, hh:mm:ss a"
    static let Formate_yymmddHHmmssa = "dd/MM/yy, hh:mm:ss a"
    static let Formate_yymmddHmmssa = "dd/MM/yy, h:mm:ss a"
    static let Formate_Email = "yyyy-MM-dd hh:mm:ss ZZZ"
    static let Formate_EmaiyymmddHHmmssa = "dd/MM/yyyy hh:mm:ss a"
    
    
    static let Formate_ddmmyyyyhhmma = "dd/MM/yyyy hh:mm a" //"16/06/2017 12:19 PM" Use this formate for all created and Modified Date. iOS User
    static let Formate_hhmma = "hh:mm a"
    static let Formate_ddmm = "dd/MM"
}

//Model Name
struct CustomModelName {
    
    //Contact Screen
    static let Data = "Data"
}




