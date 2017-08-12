//
//  UserListVC.swift
//  DataBaseTest
//
//  Created by MVJadav on 08/08/17.
//  Copyright © 2017 MVJadav. All rights reserved.
//

import UIKit
import ObjectMapper

class UserListVC: UIViewController {

    @IBOutlet var IBbarbtnAdd               : UIBarButtonItem!
    @IBOutlet weak var IBuserTbl            : UITableView!
    
    var objUser                                 : [UserModel] = []
    var userId : CLong = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        self.getUserList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: IBAction Method
extension UserListVC {
    
    @IBAction func btnClickedAddUser(_ sender: Any) {
        let objAddUserVC                    = AddUserVC(nibName: "AddUserVC", bundle: nil)
        objAddUserVC.delegate = self
        self.navigationController?.pushViewController(objAddUserVC, animated: true)
    }
    
}

extension UserListVC : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if( self.objUser.count > 0 ){
            return self.objUser.count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//                let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
//                cell.textLabel?.text        = "Title"
//                cell.detailTextLabel?.text   = "Description"
//                return cell
        
        var cell:UserListVCCell? = tableView.dequeueReusableCell(withIdentifier: "UserListVCCell") as? UserListVCCell
        if (cell == nil) {
            let nib: NSArray = Bundle.main.loadNibNamed("UserListVCCell", owner: self, options: nil)! as NSArray
            cell = nib.object(at: 0) as? UserListVCCell
        }
        cell?.selectionStyle = .none
        cell?.initObj(objUser: self.objUser[indexPath.row])
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let objAddUserVC                    = AddUserVC(nibName: "AddUserVC", bundle: nil)
        objAddUserVC.userId = self.objUser[indexPath.row].userId!
        objAddUserVC.objUserModel = self.objUser[indexPath.row]
        objAddUserVC.delegate = self
        self.navigationController?.pushViewController(objAddUserVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            
            if let userId = self.objUser[indexPath.row].userId {
                self.userId = userId
                let alert_Delete = SCLAlertView()
                alert_Delete.appearance.showCloseButton = false
                alert_Delete.addButton("Delete", target: self, selector: #selector(self.alertDeleteUser))
                alert_Delete.addButton("Cancel", target: self, selector: #selector(self.alertDeleteCancel))
                alert_Delete.showWarning(AlertTitle.Warning, subTitle: AppMessage.deleteWarning_Goal)
            }
        }
    }
    
    func alertDeleteUser() {
        self.deleteUser(userId: self.userId)
    }
    func alertDeleteCancel() { }
    
    
}

//MARK: - Other Methods
extension UserListVC {
    
    func setView() {
        setNavigation()
        self.navigationController?.navigationBar.isTranslucent = false
        self.IBuserTbl.tableFooterView = UIView()
    }
    
    func setNavigation() {
        
        self.navigationItem.rightBarButtonItems     = [IBbarbtnAdd]
        self.title = "User List"
    }
    //MARK: - Alert Function for testing only.
    func AlertMessage(msg:String){
        
        let alertController = UIAlertController(title: "Action", message: msg, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
}


//MARK: - Service Calll
extension UserListVC {

    func getUserList() {
        
        let objUserModel:UserModel  = UserModel()
        
        let query                   = DBQuery().select(Obj: objUserModel)
        let JSONString              = DBHelper.getDataWithModel(strQuery: query, key: CustomModelName.Data)
        if let response = Mapper<ServiceResponseArray<UserModel>>().map(JSONString: JSONString) {
            if let user = response.Data {
                self.objUser = user
            }
        }
        
        if self.objUser.count > 0 {
//            self.intGoalCount = self.objGoalList.count
//            self.IBsubViewNoGoalFound.isHidden = true
        } else {
//            self.intGoalCount = 0
//            self.IBsubViewNoGoalFound.isHidden = false
        }
        self.IBuserTbl.reloadData()
    }
    
    func deleteUser(userId: CLong) {
        let objUserModel:UserModel       = UserModel()
        objUserModel.userId = userId
        if DBHelper.DeleteRecordFromTable(strQuery: DBQuery().delete(Obj: objUserModel)) {
            self.userId = 0
            self.getUserList()
        }else {
            self.AlertMessage(msg: "Please try again..")
        }
    }

}


//MARK: Add User Delegate Method
extension UserListVC : AddUserDelegate {
    func didFinishAddUser() {
        self.getUserList()
    }
}


