//
//  UserModel.swift
//  DataBaseTest
//
//  Created by MVJadav on 09/08/17.
//  Copyright © 2017 MVJadav. All rights reserved.
//

import Foundation
import ObjectMapper

class UserModel: Mappable {

    lazy var userId             : CLong? = 0
    lazy var user_name          : String? = ""
    lazy var number             : String? = ""
    lazy var address            : String? = ""
    lazy var gender             : String? = ""

    
    required init(){ }
    required init?(map: Map) { }
    
    func mapping(map: Map) {

        userId              <- map["userId"]
        user_name           <- map["user_name"]
        number              <- map["number"]
        address             <- map["address"]
        gender              <- map["gender"]
    }
}

