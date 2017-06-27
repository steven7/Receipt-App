//
//  LoadUserProfileViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/1/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit
//import CoreData

struct UserInfo {
    //var userName:String
    
    var businessName:String
    var facilityAddress:String
    
    var tinyImagePath: String
    
    var userPhoneNumber:String
    var userEmailAddress:String
    var userSupervisorsName:String
    var userSupervisorsEmail:String
    
    let userKey: String
}

class LoadUserProfileViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var database = DBManager.shared
    var imageStore = ImageStore.sharedInstance
    var theusers = [User]()
    
    @IBOutlet var tableView: UITableView!
  
    
    override func viewDidLoad(){
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        print("before load")
        if(database.loadUsers() != nil){
            theusers = database.loadUsers()
            print(theusers)
        }
        print("after load")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
        tableView.reloadData()
    }
    
    
    /*
    func tableView(tableView: UITableView,
                            moveRowAtIndexPath sourceIndexPath: NSIndexPath,
                            toIndexPath destinationIndexPath: NSIndexPath) {
        // Update the model
        //userStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
    }
    */
    
    func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                            forRowAtIndexPath indexPath: NSIndexPath) {
        // If the table view is asking to commit a delete command...
        if editingStyle == .Delete {
            let user = theusers[indexPath.row] //userStore.allItems[indexPath.row]
            
            
            let title = "Delete \(user.userName)?"
            let message = "Are you sure you want to delete this item?"
            
            let ac = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .ActionSheet)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            ac.addAction(cancelAction)
            
            let deleteAction = UIAlertAction(title: "Delete", style: .Destructive,
                                             handler: { (action) -> Void in
                                                // Remove the item from the store
                                                //self.userStore.removeItem(user)
                                                self.theusers.removeAtIndex(indexPath.row)
                                                
                                                // Remove the item's image from the image store
                                                self.imageStore.deleteImageForKey(user.userKey)
                                                
                                                
                                                
                                                // Also remove that row from the table view with an animation
                                                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            })
            ac.addAction(deleteAction)
            
            // Present the alert controller
            presentViewController(ac, animated: true, completion: nil)
        }
    }
 
 
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return theusers.count //6//userStore.user.count
    }
 
    
    func tableView(tableView: UITableView,
                            cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as! QuestionCell
        
        let user = theusers[indexPath.row]
        
        cell.questionLabel?.text = user.businessName//"jizz" //user.valueForKey("businessName") as? String
        cell.detailLabel?.text = user.facilityAddress//"penis" //user.valueForKey("userEmailAddress") as?
        cell.justForShowField.hidden = true
        
        if(user.tinyImagePath == "no picture" || user.tinyImagePath == "tinyImagePath"){
            print("the path")
            print(user.tinyImagePath)
            //cell.theImage.image = imageStore.imageForKey(user.tinyImagePath)
            //cell.theImage.image =
        }else{
            print("the path")
            print(user.tinyImagePath)
            let image = imageStore.imageForKey(user.tinyImagePath)
            if(image != nil){
                cell.theImage.image = image
            }
        }
        return cell
    }

 
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //self.rowIndex = indexPath
        //self.performSegueWithIdentifier("toDetail", sender: self)
        
        database.currentUser = theusers[indexPath.row]
        
        print(database.currentUser )
        let alertController = UIAlertController(title: "User Selected!", message: "This user is now the current user", preferredStyle: .Alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "OK",
                                     style: .Default,
                                     handler: {(alert :UIAlertAction!) in
                                        print("YOU PRESSED OK")
                                        self.performSegueWithIdentifier("toStart", sender: self)
                                        //self.navigationController?.popViewControllerAnimated(true)
                                        //self.navigationController?.popToRootViewControllerAnimated(true)
        }) //You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        
        presentViewController(alertController, animated: true, completion: nil)
        
        //self.navigationController?.popViewControllerAnimated(true)
    }
}
