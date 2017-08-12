//
//  DBHelper.swift
//  iOSProject
//
//  Created by MVJadav on 12/8/16.
//  Copyright © 2016 MVJadav. All rights reserved.
//

import Foundation
import ObjectMapper

//private let SQLITE_TRANSIENT = unsafeBitCast(-1, sqlite3_destructor_type.self)


class DBHelper: NSObject {
    
    static func DatabasePath() -> NSString {
        
        let filemanager = FileManager.default
        let documentsPath : AnyObject = NSSearchPathForDirectoriesInDomains(.documentDirectory,.userDomainMask,true)[0] as AnyObject
        let destinationPath:String = documentsPath.appending("/" + DBParameter.DBName + ".db")
        if(!filemanager.fileExists(atPath: destinationPath as String) ){
            let fileForCopy = Bundle.main.path(forResource: DBParameter.DBName,ofType:"db")
            do {                try filemanager.copyItem(atPath: fileForCopy!,toPath:destinationPath as String)
            } catch _ {
            }
            print(destinationPath)
            return destinationPath as String as NSString
        } else{
            print(destinationPath)
            return destinationPath as String as NSString
        }
    }
    
    static func InsertQuery(queryString: String) -> Bool  {
        
        let path: NSString = DatabasePath()
        var database: OpaquePointer? = nil
        let dbpath = path.cString(using: String.Encoding.utf8.rawValue)
        var success: Bool = false
        var statement:OpaquePointer? = nil
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            //            while sqlite3_step(statement) == SQLITE_ROW {
            //                // Read the data from the result row
            //            }
            sqlite3_finalize(statement)
            let insertStatement = queryString
            sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                success = true
            }
            else{
                success = false
            }
            sqlite3_finalize(statement)
        }
        //}
        sqlite3_close(database)
        return success
    }
    
    
    static func InsertDataWithRespoceLastID(queryString: String) -> CLong  {
        
        let path: NSString = DatabasePath()
        var database: OpaquePointer? = nil
        let dbpath = path.cString(using: String.Encoding.utf8.rawValue)
        var LastID:CLong = 0
        var statement:OpaquePointer? = nil
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            sqlite3_finalize(statement)
            let insertStatement = queryString
            sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                let lastRowId = sqlite3_last_insert_rowid(database);
                LastID = CLong(lastRowId)
            }
            sqlite3_finalize(statement)
        }
        //}
        sqlite3_close(database)
        return LastID
    }
    
    static func GetAllData(strQuery: String) -> NSMutableArray {
        let path: NSString = DatabasePath()
        var statement: OpaquePointer?   = nil
        let dbpath                      = path.cString(using: String.Encoding.utf8.rawValue)
        var database: OpaquePointer? = nil
        let arrayList: NSMutableArray   = NSMutableArray()
        
        if sqlite3_open(dbpath, &database) == SQLITE_OK {
            //            let querySQL = strQuery
            let insertStatement = strQuery
            if sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    var i: CInt = 0;
                    var iColumnCount:CInt = 0
                    iColumnCount = sqlite3_column_count(statement)
                    let dict: NSMutableDictionary = NSMutableDictionary()
                    while i < iColumnCount {
                        let str = sqlite3_column_text(statement, i)
                        var strVal : String = ""
                        if((str != nil)){ strVal = String(cString: str!) }
                        let strFieldName = String(cString:sqlite3_column_name(statement, i), encoding:String.Encoding.utf8)
                        dict.setValue(strVal, forKey: strFieldName!);
                        i += 1;
                    }
                    arrayList.add(dict);
                }
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(database);
        return arrayList;
    }
    
    static func DeleteRecentSearch(strQuery: String) {
        
        var errMsg:UnsafeMutablePointer<Int8>? = nil
        //            sqlite3_exec(databasepath, "BEGIN TRANSACTION", nil, nil, &errMsg)
        let path: NSString = DatabasePath()
        var database: OpaquePointer? = nil
        let dbpath = path.cString(using: String.Encoding.utf8.rawValue)
        var statement:OpaquePointer? = nil
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            statement = nil
            let DeleteStatement: NSString = strQuery as NSString    //"Delete from \(TableName)" as NSString
            let cSql = DeleteStatement.cString(using: String.Encoding.utf8.rawValue)
            sqlite3_exec(database, cSql, nil, nil, &errMsg);
            sqlite3_reset(statement);
            sqlite3_finalize(statement)
            sqlite3_close(statement)
        }
    }
}

extension DBHelper {
    
    static func getDataWithModel(strQuery: String , key : String) -> String {
        let path: NSString = DatabasePath()
        var statement: OpaquePointer?   = nil
        let dbpath                      = path.cString(using: String.Encoding.utf8.rawValue)
        var database: OpaquePointer? = nil
        let arrayList: NSMutableArray   = NSMutableArray()
        
        if sqlite3_open(dbpath, &database) == SQLITE_OK {
            //            _ = strQuery
            let insertStatement = strQuery
            if sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    /*
                     var i: CInt = 0;
                     var iColumnCount:CInt = 0
                     iColumnCount = sqlite3_column_count(statement)
                     let dict: NSMutableDictionary = NSMutableDictionary()
                     while i < iColumnCount {
                     let str = sqlite3_column_text(statement, i)
                     var strVal : String = ""
                     if((str != nil)){ strVal = String(cString: str!) }
                     
                     let strFieldName = String(cString:sqlite3_column_name(statement, i), encoding:String.Encoding.utf8)
                     dict.setValue(strVal, forKey: strFieldName!);
                     i += 1;
                     }
                     arrayList.add(dict);
                     
                     */
                    arrayList.add(DBHelper.setValueForDB(statement: statement))
                    
                }
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(database);
        let dict: NSMutableDictionary = NSMutableDictionary()
        dict.setValue(arrayList, forKey: key)
        do{
            let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
            let jsonString = NSString(data: jsonData, encoding: String.Encoding.utf8.rawValue)! as String
            return jsonString;
        } catch {
            return ""
        }
    }
    
    static func setValueForDB(statement: OpaquePointer?) -> NSMutableDictionary {
        
        let dict: NSMutableDictionary = NSMutableDictionary()
        var i: CInt = 0;
        var iColumnCount:CInt = 0
        iColumnCount = sqlite3_column_count(statement)
        while i < iColumnCount {
            //            var strValue : Int? = 0
            
            let columnType:Int32 = sqlite3_column_type(statement, i);
            if (columnType == SQLITE_INTEGER) {
                var strValue: CLong? = 0
                strValue = CLong(sqlite3_column_int64(statement, i))
                //use sqlite3_column_int(statement, index)
                let strFieldName = String(cString:sqlite3_column_name(statement, i), encoding:String.Encoding.utf8)
                dict.setValue(strValue, forKey: strFieldName!)
            }
            else if (columnType == SQLITE_FLOAT) {
                //use sqlite3_column_double(statement, index)
                //                strValue = sqlite3_column_int(statement, i)
                var strValue: Double? = 0
                strValue = sqlite3_column_double(statement, i)
                //use sqlite3_column_int(statement, index)
                let strFieldName = String(cString:sqlite3_column_name(statement, i), encoding:String.Encoding.utf8)
                dict.setValue(strValue, forKey: strFieldName!)
            }
            else {
                
                //columnType == SQLITE_TEXT
                //use sqlite3_column_text(statement, index)
                let str = sqlite3_column_text(statement, i)
                var strValue : String? = ""
                if((str != nil)){ strValue = String(cString: str!) }
                let strFieldName = String(cString:sqlite3_column_name(statement, i), encoding:String.Encoding.utf8)
                dict.setValue(strValue, forKey: strFieldName!)
            }
            i += 1;
        }
        return dict
    }
    
    static func GetNameFromList(strQuery: String) -> String{
        
        var strValue: String = "";
        let path: NSString = DatabasePath()
        var database: OpaquePointer? = nil
        let dbpath = path.cString(using: String.Encoding.utf8.rawValue)
        var statement:OpaquePointer? = nil
        let cSql = strQuery.cString(using: String.Encoding.utf8)
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            if (sqlite3_prepare_v2(database, cSql!, -1, &statement, nil) == SQLITE_OK) {
                while (sqlite3_step(statement) == SQLITE_ROW) {
                    
                    let address = sqlite3_column_text(statement, 0)
                    if address != nil {
                        strValue = String(cString: address!)
                    }
                }
            }
            sqlite3_finalize(statement);
        }
        sqlite3_close(database);
        return strValue;
    }
    
    static func IsDataExist(strQuery: String) -> Bool {
        
        let path: NSString = DatabasePath()
        var statement: OpaquePointer?   = nil
        let dbpath                      = path.cString(using: String.Encoding.utf8.rawValue)
        var database: OpaquePointer? = nil
        let arrayList: NSMutableArray   = NSMutableArray()
        
        if sqlite3_open(dbpath, &database) == SQLITE_OK {
            //            let querySQL = strQuery
            let insertStatement = strQuery
            if sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil) == SQLITE_OK {
                while sqlite3_step(statement) == SQLITE_ROW {
                    
                    arrayList.add(DBHelper.setValueForDB(statement: statement))
                }
                sqlite3_finalize(statement);
            }
        }
        sqlite3_close(database);
        
        if arrayList.count > 0 {
            return true
        }
        return false
    }
    
    static func DeleteRecordFromTable(strQuery: String) -> Bool {
        
        var success: Bool = false
        var errMsg:UnsafeMutablePointer<Int8>? = nil
        //            sqlite3_exec(databasepath, "BEGIN TRANSACTION", nil, nil, &errMsg)
        let path: NSString = DatabasePath()
        var database: OpaquePointer? = nil
        let dbpath = path.cString(using: String.Encoding.utf8.rawValue)
        var statement:OpaquePointer? = nil
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            statement = nil
            let DeleteStatement: NSString = strQuery as NSString    //"Delete from \(TableName)" as NSString
            let cSql = DeleteStatement.cString(using: String.Encoding.utf8.rawValue)
            //            let cSql = strQuery.cString(using: String.Encoding.utf8)
            sqlite3_exec(database, cSql, nil, nil, &errMsg);
            if errMsg == nil {
                success = true
            }
            sqlite3_reset(statement);
            sqlite3_finalize(statement)
            sqlite3_close(statement)
        }
        return success
        
    }
    
    static func GeneralQuery(queryString: String) -> Bool  {
        
        let path: NSString = DatabasePath()
        var database: OpaquePointer? = nil
        let dbpath = path.cString(using: String.Encoding.utf8.rawValue)
        var success: Bool = false
        var statement:OpaquePointer? = nil
        if (sqlite3_open(dbpath, &database) == SQLITE_OK) {
            //            while sqlite3_step(statement) == SQLITE_ROW {
            //                // Read the data from the result row
            //            }
            sqlite3_finalize(statement)
            let insertStatement = queryString
            sqlite3_prepare_v2(database, insertStatement, -1, &statement, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                success = true
            }
            else{
                success = false
            }
            sqlite3_finalize(statement)
        }
        //}
        sqlite3_close(database)
        return success
    }
    
}
