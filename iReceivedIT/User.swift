//
//  Copyright © 2015 Big Nerd Ranch
//

import Foundation

class User: NSObject {
    
    var userName:String
    
    var businessName:String
    var facilityAddress:String
    
    var tinyImagePath: String
    
    var userPhoneNumber:String
    var userEmailAddress:String
    var userSupervisorsName:String
    var userSupervisorsEmail:String
    
    let userKey: String
 
    init( businessName:String, facilityAddress:String, tinyImagePath: String, userPhoneNumber:String,userEmailAddress:String, userSupervisorsName:String, userSupervisorsEmail:String) {
    
        self.userName = "Bill Clinton"
        
        if(businessName  != ""){
            self.businessName = businessName
        }else{
            self.businessName = "no entry"
        }
        if(facilityAddress != ""){
            self.facilityAddress = facilityAddress
        }else{
            self.facilityAddress = "no entry"
        }
        if(tinyImagePath != ""){
            self.tinyImagePath = tinyImagePath
        }else{
            self.tinyImagePath = "no entry"
        }
        if(userPhoneNumber != ""){
            self.userPhoneNumber = userPhoneNumber
        }else{
            self.userPhoneNumber = "no entry"
        }
        if(userEmailAddress != ""){
            self.userEmailAddress = userEmailAddress
        }else{
            self.userEmailAddress = "no entry"
        }
        if(userSupervisorsName != ""){
            self.userSupervisorsName = userSupervisorsName
        }else{
            self.userSupervisorsName = "no entry"
        }
        if(userSupervisorsEmail != ""){
            self.userSupervisorsEmail = userSupervisorsEmail
        }else{
            self.userSupervisorsEmail = "no entry"
        }
        
        self.userKey = NSUUID().UUIDString
    }
    
}
