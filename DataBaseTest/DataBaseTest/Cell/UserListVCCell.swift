//
//  UserListVCCell.swift
//  DataBaseTest
//
//  Created by MVJadav on 09/08/17.
//  Copyright © 2017 MVJadav. All rights reserved.
//

import UIKit

class UserListVCCell: UITableViewCell {

    @IBOutlet weak var IBname: UILabel!
    @IBOutlet weak var IBlblNumber: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension UserListVCCell {
    
    func setView() {
        self.IBname.text = ""
        self.IBlblNumber.text = ""
    }
    
    func initObj(objUser : UserModel) {
        
        if let name = objUser.user_name {
            self.IBname.text = name
        }
        if let number = objUser.number {
            self.IBlblNumber.text = number
        }
        
    }
}
