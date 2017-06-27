//
//  Copyright © 2015 Big Nerd Ranch
//

import Foundation
/*
class UserStore {
    
    var allItems: [User] = []
    
    
    
    let userArchiveURL: NSURL = {
        let documentsDirectories =
            NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let documentDirectory = documentsDirectories.first!
        print("\(documentDirectory)")
        return documentDirectory.URLByAppendingPathComponent("users.archive")!
    }()
    
    func saveChanges() -> Bool {
        print("Saving items to: \(userArchiveURL.path!)")
        return NSKeyedArchiver.archiveRootObject(allItems, toFile: userArchiveURL.path!)
    }
    
    init(){
        print("yay user store!")
        if let archivedItems =
            NSKeyedUnarchiver.unarchiveObjectWithFile(userArchiveURL.path!) as? [User] {
            allItems += archivedItems
        }
    }
    
    func moveItemAtIndex(fromIndex: Int, toIndex: Int) {
        if fromIndex == toIndex {
            return
        }
        
        // Get reference to object being moved so you can re-insert it
        let movedItem = allItems[fromIndex]
        
        // Remove item from array
        allItems.removeAtIndex(fromIndex)
        
        // Insert item in array at new location
        allItems.insert(movedItem, atIndex: toIndex)
    }
    
    func createUser() -> User {
        /*
        if(createbusinessNameField.text != nil){
            self.businessName = createbusinessNameField.text!
        }
        if(createfacilityAddressField.text != nil){
            self.facilityAddress = createfacilityAddressField.text!
        }
        //if(createbusinessNameField.text != nil){
        //    self.tinyImagePath = createbusinessNameField.text
        //}
        if(createuserPhoneNumberField.text != nil){
            self.userPhoneNumber = createuserPhoneNumberField.text!
        }
        if(createuserEmailAddressField.text != nil){
            self.userEmailAddress = createuserEmailAddressField.text!
        }
        if(createuserSupervisorsNameField.text != nil){
            self.userSupervisorsName = createuserSupervisorsNameField.text!
        }
        if(createuserSupervisorsEmailField.text != nil){
            self.userSupervisorsEmail = createuserSupervisorsEmailField.text!
        }
        */
        let newItem = User()
        
        allItems.append(newItem)
        
        return newItem
    }
    
    func removeItem(item: User) {
        if let index = allItems.indexOf(item) {
            allItems.removeAtIndex(index)
        }
    }
    
}
 */
