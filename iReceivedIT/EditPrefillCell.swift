//
//  EditPrefillCell.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/21/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit

class EditPrefillCell: UITableViewCell { //, UITextViewDelegate {

    
    @IBOutlet var prefillTextField: UITextView!
    
    var pageIndex:Int!
    var pageRow:Int!
    var key:Int!
    
    var database = DBManager.shared
    let data = QuestionStore.sharedInstance
    var optionPrefill:String! = nil
    var prefillColumns: [String: String] = [:]
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        print("cell loaded")
        
        //self.prefillTextField.delegate = self
        
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
        let plusThree = database.field_Prefill_Plus_Three
        
        prefillColumns = ["Receiving Location" : goodsDescription, "Supplier" : locationReceived,"PO Number" : pONumber, "BOL Number" : weight, "Trailer/Truck Number" : bOLNuber, "Material Description" : rebate , "Weight" : cost, "UOM" : dateReceived , "Cost" : paymentDueDate , "Rebate" : other, "Payment Amount" : plusOne, "Payment Due Date": plusTwo]
        
    }
    
    func updateFieldFromDict(){
        //key = (pageIndex * 100) + pageRow
        if data.inputDictionary[key] != nil{
            //segementedControl.setEnabled(true, forSegmentAtIndex: key)
            //okSwitch.on = true
            if data.inputDictionary[key] != "no answer"{
                //detailLabel.text = data.inputDictionary[key]
                //PrefillTextField.text = data.inputDictionary[key]
                print("was already on with value \(data.inputDictionary[key])")
            }
        }else{
            //detailLabel.text = ""
            //PrefillTextField.text = ""
            //data.inputDictionary.updateValue("no answer", forKey:key)
            print("was not already on the field was")
        }
    }
    
    /*
    func textViewDidEndEditing(textView: UITextView){
        //NSLog("end editing now")
        //NSLog("entered value is %@", textView.text!)
        //let key = (pageIndex * 100) + pageRow
        //data.inputDictionary.updateValue(textField.text!, forKey:key)
        //cell = self.tableView.cellForRowAtIndexPath( NSIndexPath(forRow: textField.tag, inSection: 0) ) as! InputCell
        //let  key = (index * 100) + row
        
        //let userInput = textView.text
        //self.saveToDatabase(userInput)
        
        let userInput = textView.text
        print("saving \(userInput) to \(textView.text)")
        self.saveToDatabase(userInput)
    
        //updateStringDictionary(textView.text!, dictKey: key)
    }
    
    func saveToDatabase(thenewRecord:String){
        
        let prefillColumn = prefillColumns[optionPrefill]
        //print("lets see whats at: \(prefillColumn)")
        let toInsert = [thenewRecord]
        //database.insertPrefillData(toInsert, prefillColumn: prefillColumn!)
        database.updatePrefillData(toInsert, prefillColumn: prefillColumn!)
    }

    func textFieldShouldReturn(textField: UITextField) -> Bool{
        // if textField == inputText{
        //   text
        // }
        
        textField.resignFirstResponder()
        return true
    }
    */
    
}
