//
//  DBConstant.swift
//  iOSProject
//
//  Created by MVJadav on 12/8/16.
//  Copyright © 2016 MVJadav. All rights reserved.
//

import Foundation
import ObjectMapper

struct DBParameter {
    
    ///MARK: - SqlLite DatabseName
    static let DBName = "Data"
}


struct DBTableName {
    
    //MARK: SQlite Table Name
    static let User                          = "User"
}

// MARK: - SQL Query
struct DBQuery {
    
    func select<T>(Obj:T) -> String {
        
        var insertSQl : String = ""
        
        if (Obj is UserModel) {
            //let objAddEditProductPostModel = Obj as! UserModel;
            insertSQl = "Select * from \(DBTableName.User) ORDER BY userId DESC"
        }
        
        return insertSQl
    }
    
    func insert<T>(Obj:T) -> String {
        
        var insertSQl : String = ""
        if (Obj is UserModel) {
            let objUserModel = Obj as! UserModel
            insertSQl = "insert into \(DBTableName.User) (user_name, number, address, gender) values(\"\(objUserModel.user_name!)\",\"\(objUserModel.number!)\",\"\(objUserModel.address!)\",\"\(objUserModel.gender!)\")"
        }
        return insertSQl
    }
    
    
    func update<T>(Obj:T) -> String {
        
        var updateSQl : String = ""
        if (Obj is UserModel) {
            let objUserModel = Obj as! UserModel
            updateSQl = "UPDATE \(DBTableName.User) SET user_name=\"\(objUserModel.user_name!)\", number=\"\(objUserModel.number!)\",address=\"\(objUserModel.address!)\",gender=\"\(objUserModel.gender!)\" WHERE userId=\"\(objUserModel.userId!)\""
        }
        return updateSQl
    }
    
    func delete<T>(Obj:T) -> String {
        var deleteSQl : String = ""
        //ContactModel
        if (Obj is UserModel) {
            let objUserModel = Obj as! UserModel;
            deleteSQl = "Delete FROM \(DBTableName.User) WHERE userId = \(objUserModel.userId!)"
            
        }
        return deleteSQl
    }
}





