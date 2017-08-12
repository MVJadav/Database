//
//  AddUserVC.swift
//  DataBaseTest
//
//  Created by MVJadav on 08/08/17.
//  Copyright © 2017 MVJadav. All rights reserved.
//

import UIKit

@objc protocol AddUserDelegate:class {
    @objc optional func didFinishAddUser()
}


class AddUserVC: UIViewController {

    
    var delegate:AddUserDelegate?
    
    @IBOutlet weak var IBtxtName                : UITextField!
    @IBOutlet weak var IBtxtNumber              : UITextField!
    @IBOutlet weak var IBtxtAddress             : UITextField!
    @IBOutlet weak var IBbtnMale                : UIButton!
    @IBOutlet weak var IBbtnFemale              : UIButton!
    @IBOutlet var IBbarbtnBack                  : UIBarButtonItem!
    @IBOutlet var IBbarbtnAddUser               : UIBarButtonItem!
    @IBOutlet weak var IBSubviewNameError       : UIView!
    @IBOutlet weak var IBSubviewNumberError     : UIView!
    @IBOutlet weak var IBSubviewAddressError    : UIView!
    
    
    
    var userId : CLong = 0
    var objUserModel:UserModel                        = UserModel()
    var gender = "Male"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setView()
        if self.userId > 0 {
            self.setData()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//MARK: -IBAction Methods
extension AddUserVC {
    
    @IBAction func clickOnGender(_ sender: UIButton) {
        
        if sender.tag == 101 {
            self.IBbtnMale.backgroundColor        = AppColor.AppTheme_Primary
            self.IBbtnMale.setTitleColor(UIColor.white, for: .normal)
            
            self.IBbtnFemale.backgroundColor        = UIColor.lightGray
            self.IBbtnFemale.setTitleColor(AppColor.Dark_Black, for: .normal)
            self.gender = "Male"
        }else {
            self.IBbtnFemale.backgroundColor        = AppColor.AppTheme_Primary
            self.IBbtnFemale.setTitleColor(UIColor.white, for: .normal)
            
            self.IBbtnMale.backgroundColor        = UIColor.lightGray
            self.IBbtnMale.setTitleColor(AppColor.Dark_Black, for: .normal)
            self.gender = "Female"
        }
    }
    
    //btnBack Click
    @IBAction func barbtnBackClick(sender: AnyObject) {
        _ =  self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnClickAddUser(_ sender: AnyObject) {
        
        if ValidationAll() {
            self.addUser()
        }
    }
    
}

//MARK: - Other Methods
extension AddUserVC {
    
    
    func setView() {
        self.setNavigation()
        
        self.IBbtnMale.backgroundColor        = AppColor.AppTheme_Primary
        self.IBbtnMale.setTitleColor(UIColor.white, for: .normal)
        self.IBbtnFemale.backgroundColor        = UIColor.lightGray
        self.IBbtnFemale.setTitleColor(AppColor.Dark_Black, for: .normal)
    }
    
    func setData() {
        
        if let name = self.objUserModel.user_name {
            self.IBtxtName.text = name
        }
        if let number = self.objUserModel.number {
            self.IBtxtNumber.text = number
        }
        if let address = self.objUserModel.address {
            self.IBtxtAddress.text = address
        }
        if let gender = self.objUserModel.gender {
            self.gender = gender
            if self.gender == "Male" {
                self.IBbtnMale.backgroundColor        = AppColor.AppTheme_Primary
                self.IBbtnMale.setTitleColor(UIColor.white, for: .normal)
                
                self.IBbtnFemale.backgroundColor        = UIColor.lightGray
                self.IBbtnFemale.setTitleColor(AppColor.Dark_Black, for: .normal)
            }else {
                self.IBbtnFemale.backgroundColor        = AppColor.AppTheme_Primary
                self.IBbtnFemale.setTitleColor(UIColor.white, for: .normal)
                
                self.IBbtnMale.backgroundColor        = UIColor.lightGray
                self.IBbtnMale.setTitleColor(AppColor.Dark_Black, for: .normal)
            }
            
        }
        
    }
    
    func setNavigation(isCompleted : Bool? = false) {
        
        self.navigationItem.leftBarButtonItem       = IBbarbtnBack
        self.navigationItem.rightBarButtonItems     = [IBbarbtnAddUser]
        
        if userId > 0 {
            self.navigationItem.titleView = Common().setNavigationBarTitle(title: AppConstant.title, subtitle: "Edit User")
        }else {
            self.navigationItem.titleView = Common().setNavigationBarTitle(title: AppConstant.title, subtitle: "New User")
        }
        
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

//MARK: - Validation Methods
extension AddUserVC {
    
    func ValidationAll() -> Bool{
        
        var falg:Bool = true
        if(self.Validation(textField: self.IBtxtName) == false){
            falg = false
        }else if(self.Validation(textField: self.IBtxtNumber) == false){
            falg = false
        }else if(self.Validation(textField: self.IBtxtAddress) == false){
            falg = false
        }
        return falg
    }
    
    func Validation(textField: UITextField) -> Bool {
        var flag:Bool = true
        
        if textField == IBtxtName {
            if IBtxtName.text?.isEmptyField == true {
                //self.AlertMessage(msg: "Insert Name")
                self.IBSubviewNameError.backgroundColor = UIColor.red
                flag = false;
            }else {
                self.IBSubviewNameError.backgroundColor = UIColor.lightGray
            }
        }
        if textField == IBtxtNumber {
            if IBtxtNumber.text?.isEmptyField == true {
                //self.AlertMessage(msg: "Insert Number")
                self.IBSubviewNumberError.backgroundColor = UIColor.red
                flag = false;
            }else {
                self.IBSubviewNumberError.backgroundColor = UIColor.lightGray
            }
        }
        if textField == IBtxtAddress {
            if IBtxtAddress.text?.isEmptyField == true {
                //self.AlertMessage(msg: "Insert Address")
                self.IBSubviewAddressError.backgroundColor = UIColor.red
                flag = false;
            }else {
                self.IBSubviewAddressError.backgroundColor = UIColor.lightGray
            }
        }
        return flag
    }
}

//MARK: - UITextField Delegate methods
extension AddUserVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if(textField==self.IBtxtNumber){
            let maxLength = 10
            let currentString: NSString = textField.text! as NSString
            let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
            return newString.length <= maxLength
        }
        return true
    }
    /*
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        self.Validation(textField: textField)
        return true
    }
    */
}

//MARK: -Service Call
extension AddUserVC {
    
    func addUser() {
        
        //let objUserModel : UserModel              = UserModel()
        
        if (self.IBtxtName.text?.isEmpty)! {}else{
            objUserModel.user_name = self.IBtxtName.text
        }
        if (self.IBtxtNumber.text?.isEmpty)! {}else{
            objUserModel.number = self.IBtxtNumber.text
        }
        if (self.IBtxtAddress.text?.isEmpty)! {}else{
            objUserModel.address = self.IBtxtAddress.text
        }
        objUserModel.gender = self.gender
        
        var query = ""
        if self.userId > 0 {
            query = DBQuery().update(Obj: objUserModel)
        }else {
            query = DBQuery().insert(Obj: objUserModel)
        }
        if DBHelper.GeneralQuery(queryString: query) {
            //Common().updateGoalStatus(strUserId: objGoal.UserId!)
            self.delegate?.didFinishAddUser!()
             _ =  self.navigationController?.popViewController(animated: true)
        }else {}
    }
    
}


