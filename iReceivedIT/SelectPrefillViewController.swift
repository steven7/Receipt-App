//
//  SelectPrefillViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/5/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import Foundation

class SelectPreFillOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var tableView:UITableView!
    
    //let options = ["Goods Description","Location Received","PO#","Weight","BOL#","Rebate","Cost","Date Received","Payment Due Date","Other"]
    
    let options = ["Receiving Location","Supplier","PO Number","BOL Number","Trailer/Truck Number","Material Description","Weight","UOM","Cost","Rebate","Payment Amount","Payment Due Date"]
    
    override func viewDidLoad() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count //6//userStore.user.count
    }
    
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell") //as! UITableViewCell
        
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.performSegueWithIdentifier("toSetPrefill", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if the triggered segue is the "showitem" segue
        if segue.identifier == "toSetPrefill"{
            
            // Figure out which row was tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                let detailViewController
                    = segue.destinationViewController as! SetPreFillOptionsViewController
                print("we are at row \(row)")
                print(options[row])
                detailViewController.optionPrefill = options[row]
                
           
            }
            
        }
    }
}
