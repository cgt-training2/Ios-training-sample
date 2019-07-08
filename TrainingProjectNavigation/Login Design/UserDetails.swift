//
//  UserDetails.swift
//  TrainingProjectNavigation
//
//  Created by MohitM on 26/06/19.
//  Copyright © 2019 MohitM. All rights reserved.
//

import Foundation

class UserDetails {
    var email: String?
    var fstName: String?
    var lstName: String?
    var passwd: String?
    var cnfpasswd: String?
    var contact: Int
    
    init(email: String?, fstName: String?, lstName: String?, passwd: String?, cnfpasswd: String?, contact:Int){
        self.email = email
        self.fstName = fstName
        self.lstName = lstName
        self.passwd = passwd
        self.cnfpasswd = cnfpasswd
        self.contact = contact
    }
   

}
