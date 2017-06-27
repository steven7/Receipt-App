//
//  SavedReceiptsViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/1/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import Foundation

class SavedReceiptsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        
        //var userStore: UserStore!
        var imageStore: ImageStore!
        
        var database = DBManager.shared
        var thereceipts = [Receipt]()
        
        @IBOutlet var tableView: UITableView!
        
        
        override func viewDidLoad(){
            super.viewDidLoad()
            tableView.delegate = self
            tableView.dataSource = self
            
            print("before")
            if(database.loadUsers() != nil){
                thereceipts = database.loadReceipts()
            }
            print("after")
            print(thereceipts)
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
         userStore.moveItemAtIndex(sourceIndexPath.row, toIndex: destinationIndexPath.row)
         }
         
         func tableView(tableView: UITableView,
         commitEditingStyle editingStyle: UITableViewCellEditingStyle,
         forRowAtIndexPath indexPath: NSIndexPath) {
         // If the table view is asking to commit a delete command...
         if editingStyle == .Delete {
         let user = userStore.allItems[indexPath.row]
         
         
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
         self.userStore.removeItem(user)
         
         // Remove the item's image from the image store
         //self.imageStore.deleteImageForKey(user.userKey)
         
         // Also remove that row from the table view with an animation
         self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
         })
         ac.addAction(deleteAction)
         
         // Present the alert controller
         presentViewController(ac, animated: true, completion: nil)
         }
         }
         
         */
        
        func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            print(thereceipts.count )
            return thereceipts.count  
        }
        
        func tableView(tableView: UITableView,
                       cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("basicCell", forIndexPath: indexPath) as! QuestionCell
            
            let receipt = thereceipts[indexPath.row]
            
            cell.questionLabel?.text = receipt.locationReceived /// Suplier
            cell.detailLabel?.text = "Created on \(receipt.dateCreated)"
            cell.justForShowField.hidden = true
            print(receipt.locationReceived)
            
            return cell
        }
    
    
        
        func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            //self.rowIndex = indexPath
            //self.performSegueWithIdentifier("toDetail", sender: self)
            
            //database.currentUser = theusers[indexPath.row]
            
            print(thereceipts[indexPath.row])
            
            //self.navigationController?.popViewControllerAnimated(true)
        }
    
        override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            //if the triggered segue is the "showitem" segue
            if segue.identifier == "toLookOnly"{
                if let row = tableView.indexPathForSelectedRow?.row {
                    
                    print(row)
                    // Get the item associated with this row and pass it along
                    //    let item = itemStore.allItems[row]
                    
                    let detailViewController
                        = segue.destinationViewController as! OnlyLookRootViewController
                    detailViewController.receiptToShow = thereceipts[row]
                }
            }
            
        }
}
