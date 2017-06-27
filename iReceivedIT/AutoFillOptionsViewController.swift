//
//  AutoFillOptionsViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/1/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import Foundation

class AutoFillOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var tableView: UITableView!
    
    var database = DBManager.shared
    
    var optionPrefill:String!
    var options = [" "]
    var prefillColumns: [String: String] = [:]
    var prefillCarryover: [String: String] = [:]
    
    override func viewDidLoad(){
        
        print(optionPrefill)
        
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        let goodsDescription = database.field_Prefill_GoodsDescription
        let locationReceived = database.field_Prefill_LocationReceived
        let pONumber = database.field_Prefill_PONumber
        let weight = database.field_Prefill_Weight
        let bOLNuber = database.field_Prefill_BOLNuber
        let rebate = database.field_Prefill_Rebate
        let cost = database.field_Prefill_Cost
        let dateReceived = database.field_Prefill_DateReceived
        let paymentDueDate = database.field_Prefill_PaymentDueDate
        let other = database.field_Prefill_Other
        
        let plusOne = database.field_Prefill_Plus_One
        let plusTwo = database.field_Prefill_Plus_Two

        
        //prefillColumns = ["Goods Description" : goodsDescription,"Location Received" : locationReceived,"PO#" : pONumber, "Weight" : weight, "BOL#" : bOLNuber, "Rebate" : rebate , "Cost" : cost, "Date Received" : dateReceived , "Payment Due Date" : paymentDueDate , "Other" : other]
        
        prefillColumns = ["Receiving Location" : goodsDescription, "Supplier" : locationReceived,"PO Number" : pONumber, "BOL Number" : weight, "Trailer/Truck Number" : bOLNuber, "Material Description" : rebate , "Weight" : cost, "UOM" : dateReceived , "Cost" : paymentDueDate , "Rebate" : other, "Payment Amount" : plusOne, "Payment Due Date": plusTwo]
        
        loadFromDatabase()
    }
    
    func loadFromDatabase(){
        let prefillColumn = prefillColumns[optionPrefill]
        print(prefillColumn)
        if(database.loadPrefill(prefillColumn!) != nil){
            options = database.loadPrefill(prefillColumn!)
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count //6//userStore.user.count
    }
    
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        
        cell.textLabel?.text = options[indexPath.row]
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // set pre fill text field
        
        let whichcarry  = prefillCarryover[optionPrefill]
        
        let carry = options[indexPath.row]
        
        database.carryover_Prefill = carry
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}
