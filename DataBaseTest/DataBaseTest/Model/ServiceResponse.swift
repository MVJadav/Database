//
//  serviceResponse.swift
//  iOSProject
//
//  Created by MVJadav NewMac on 12/8/16.
//  Copyright © 2016 MVJadav. All rights reserved.
//

import UIKit
import ObjectMapper

class ServiceResponse<T: Mappable>: Mappable {
    
    lazy var IsSuccess      : Bool? = false
    lazy var Code           : String? = ""
    lazy var Message        : String? = ""
    var Data                : T?
    
    init?() {
        
    }
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        IsSuccess       <- map["IsSuccess"]
        Code            <- map["Code"]
        Message         <- map["Message"]
        Data            <- map["Data"]
        
    }
}
class AnyData: Mappable {
    
    var Data:AnyObject?
    
    init?() {
        
    }
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        Data       <- map["Data"]
    }
}

class ServiceResponsewithError<T: Mappable, E: Mappable>: Mappable {
    
    var IsSuccess: Bool?
    var Code: Int?
    var Message: String?
    var Data: T?
    var Errors: [E]?
    
    init?() {
        
    }
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        IsSuccess    <- map["IsSuccess"]
        Code         <- map["Code"]
        Message      <- map["Message"]
        Data       <- map["Data"]
        Errors       <- map["Errors"]
        
    }
}


class ServiceResponseArray<T: Mappable>: Mappable {
    
    var IsSuccess: Bool?
    var Code: String?
    var Message: String?
    var Data: [T]?
    
    init?() {
        
    }
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        IsSuccess    <- map["IsSuccess"]
        Code         <- map["Code"]
        Message      <- map["Message"]
        Data       <- map["Data"]
        
    }
}

class ServiceResponseMessage: Mappable, CustomStringConvertible {
    
    var IsSuccess: Bool? = false
    var Code: String? = ""
    var Message: String? = ""
    
    init?() {
        
    }
    required init?(map: Map) {}
    
    var description: String {
        get {
            return Mapper().toJSONString(self, prettyPrint: false)!
        }
    }
    // Mappable
    func mapping(map: Map) {
        IsSuccess    <- map["IsSuccess"]
        Code         <- map["Code"]
        Message      <- map["Message"]
    }
}
