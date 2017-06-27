//
//  OnlyLookDataViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/7/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import Foundation

import UIKit
import MessageUI

class OnlyLookDataViewController: UIViewController, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var dataObject: String = ""
    
    var receiptToShow:Receipt!
    
    let data = QuestionStore.sharedInstance
    var database = DBManager.shared
    var imageStore = ImageStore.sharedInstance
    
    var mailSent:Bool = false
    var pageIndex:Int! = nil
    var rowIndex:Int! = nil
    var first:Bool = false
    var last:Bool = false
    
    let threshold = CGFloat(30.0)
    var isLoadingMore = false
    
    //var list = questions.theQuestions//getQuestions()
    /*
    var fieldDict: [Int :String] = [
        0:"Goods Description",
        1:"Location Recieved",
        2:"PO#",
        3:"Weight",
        4:"BOL#",
        100:"Rebate",
        101:"Cost",
        102:"Date Recieved",
        103:"Payment Due Date",
        104:"Other",
        1000:"User Picture"//,
        //15:"Goods Description"
    ]
    */
    
    var fieldDict: [Int :String] = [
        0:"Receiving Location",
        1:"Supplier",
        2:"PO Number",
        3:"BOL Number",
        4:"Trailer/Truck Number",
        5:"Material Description",
        6:"Weight",
        7:"UOM",
        8:"Cost",
        9:"Rebate",
        10:"Payment Amount",
        11:"Payment Due Date",
        100:"Rebate",
        101:"Cost",
        102:"Date Recieved",
        103:"Payment Due Date",
        104:"Other",
        1000:"User Picture"
    ]
    
    @IBOutlet var submitButton: UIButton!
    
    @IBOutlet var backToStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.extendedLayoutIncludesOpaqueBars = true;
        // Do any additional setup after loading the view, typically from a nib.
        //self.navigationController?.navigationBar.hidden = true
        self.navigationController?.navigationBar.translucent = false
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.backToStartButton.enabled = false
        self.backToStartButton.hidden = true
        self.submitButton.enabled = false
        self.submitButton.alpha = 0.5

        var key = 0
        //updateEachDictFromStorage(0)
        //updateEachDictFromStorage(1)
        while key < 14{
            updateEachDictFromStorage(key)
            key += 1
        }
        print(data.inputDictionary)
        print(data.imageDictionary)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //self.dataLabel!.text = questionsList.theTitles[index]//dataObject
        self.extendedLayoutIncludesOpaqueBars = true;
        self.tableView!.reloadData()
        
        
        //self.subscribeToKeyboardNotifications()
        /*
         if(pageIndex == 0){
         backToStartButton.hidden = false
         }else{
         backToStartButton.hidden = true
         }
         */
        if(pageIndex == 0){
            self.submitButton.hidden = false
            self.submitButton.layer.cornerRadius = 5
            self.submitButton.layer.borderWidth = 1
            let greenColor = UIColor(hexString: "63FF7A")
            self.submitButton.layer.borderColor = self.view.tintColor.CGColor
        }else{
            self.submitButton.hidden = true
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func backToStartButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("backToStart", sender: self)
    }
    
    func pullOutOfDatabse(){
        
    }
    
    func printDicts(){
        print("input dictionary")
        for (key, value) in data.inputDictionary {
            print("Dictionary key \(key) -  Dictionary value \(value)")
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if the triggered segue is the "showitem" segue
        if segue.identifier == "toDetailView"{
            
            // Figure out which row was tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                
                print(row)
                
                let detailViewController
                    = segue.destinationViewController as! DetailViewController
                detailViewController.index = self.pageIndex
                detailViewController.row = row
                detailViewController.key = row
                             }
            
        }
    }
    
    func updateStringDictionary(inputString: String, dictKey:Int){
        if(inputString != "" && inputString != "no entry"){
            data.inputDictionary.updateValue(inputString, forKey:dictKey)
        }else{
            data.inputDictionary.updateValue(" ", forKey:dictKey)
        }
    }
    
    func updateImageDictionary(imageKey:String!, key:Int){
        let image = imageStore.imageForKey( imageKey )
        if((image) != nil){
            print("is there an image? \(image)")
            data.imageDictionary.updateValue(image!, forKey:key)
            print("this better not crash")
        }
        //else{
        //    let image = UIImage(named: "Camera")
        //    data.imageDictionary.updateValue(image!, forKey:key)
        //}
    }
    
    func updateEachDictFromStorage(key:Int){
        if(pageIndex == 0){
            switch key {
            case 0:
                let inputKey = receiptToShow.goodsDescription
                updateStringDictionary(inputKey, dictKey: key)
                print(receiptToShow.goodsDescription_ImagePath)
                let imageKey = receiptToShow.goodsDescription_ImagePath/*
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil) ){
                    let image = imageStore.imageForKey( imageKey )
                    data.imageDictionary.updateValue(image!, forKey:key)
                }else{
                    let image = UIImage(named: "Camera")
                    data.imageDictionary.updateValue(image!, forKey:key)
                }*/
                updateImageDictionary(imageKey, key: key)
            case 1:
                let inputKey = receiptToShow.locationReceived
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.locationReceived_ImagePath
                print(imageKey)
                //if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil) ){
                updateImageDictionary(imageKey, key: key)
            case 2:
                let inputKey = receiptToShow.pONumber
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.pONumber_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 3:
                let inputKey = receiptToShow.weight
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.weight_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 4:
                let inputKey = receiptToShow.bOLNuber
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.bOLNuber_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 5:
                let inputKey = receiptToShow.rebate
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.rebate_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 6:
                let inputKey = receiptToShow.cost
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.cost_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 7:
                let inputKey = receiptToShow.dateReceived
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.dateReceived_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 8:
                let inputKey = receiptToShow.paymentDueDate
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.paymentDueDate_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 9:
                let inputKey = receiptToShow.other
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.other_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 10:
                let inputKey = receiptToShow.plusOne
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.plusOne_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 11:
                let inputKey = receiptToShow.plusTwo
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.plusTwo_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 12:
                let inputKey = receiptToShow.plusOne
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.plusOne_ImagePath
                updateImageDictionary(imageKey, key: key)
            case 13:
                let inputKey = receiptToShow.plusTwo
                updateStringDictionary(inputKey, dictKey: key)
                let imageKey = receiptToShow.plusTwo_ImagePath
                updateImageDictionary(imageKey, key: key)
            default: break
                //cell.detailLabel.text = " "
                //updateStringDictionary(" ", dictKey: 0)
            }
 
        }
    }
    
    
    /////////////////////////////
    ///
    ///    table view methods
    ///
    ///////////////////////////////
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("basicCell") as! QuestionCell
        
        cell.questionLabel?.text = data.getQuestions()[pageIndex][indexPath.row]
        cell.justForShowField.enabled = false
        cell.key = indexPath.row
        cell.pageIndex = self.pageIndex
        cell.pageRow = indexPath.row
        cell.updateFieldFromDict()
        cell.updateImageFromDict()
        
        /*
        if(pageIndex == 0){
            switch indexPath.row {
            case 0:
                cell.detailLabel.text = receiptToShow.goodsDescription
                print(receiptToShow.goodsDescription_ImagePath)
                let imageKey = receiptToShow.goodsDescription_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil) ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 1:
                cell.detailLabel.text = receiptToShow.locationReceived
                let imageKey = receiptToShow.locationReceived_ImagePath
                if( (receiptToShow.locationReceived_ImagePath != "No Description") || (receiptToShow.locationReceived_ImagePath != "no entry") || (receiptToShow.locationReceived_ImagePath != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 2:
                cell.detailLabel.text = receiptToShow.pONumber
                let imageKey = receiptToShow.pONumber_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 3:
                cell.detailLabel.text = receiptToShow.weight
                let imageKey = receiptToShow.weight_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
                
            case 4:
                cell.detailLabel.text = receiptToShow.bOLNuber
                let imageKey = receiptToShow.bOLNuber_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
                
            
            case 5:
                cell.detailLabel.text = receiptToShow.rebate
                let imageKey = receiptToShow.rebate_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 6:
                cell.detailLabel.text = receiptToShow.cost
                let imageKey = receiptToShow.cost_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 7:
                cell.detailLabel.text = receiptToShow.dateReceived
                let imageKey = receiptToShow.dateReceived_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 8:
                cell.detailLabel.text = receiptToShow.paymentDueDate
                let imageKey = receiptToShow.paymentDueDate_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 9:
                cell.detailLabel.text = receiptToShow.other
                let imageKey = receiptToShow.other_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 10:
                cell.detailLabel.text = receiptToShow.plusOne
                let imageKey = receiptToShow.plusOne_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 11:
                cell.detailLabel.text = receiptToShow.plusTwo
                let imageKey = receiptToShow.plusTwo_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            
            /*
            case 12:
                cell.detailLabel.text = receiptToShow.other
                let imageKey = receiptToShow.other_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            */
            default:
                cell.detailLabel.text = " "
            }
        }else if (pageIndex == 1){
            switch indexPath.row {
            case 0:
                cell.detailLabel.text = receiptToShow.rebate
                let imageKey = receiptToShow.rebate_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 1:
                cell.detailLabel.text = receiptToShow.cost
                let imageKey = receiptToShow.cost_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 2:
                cell.detailLabel.text = receiptToShow.dateReceived
                let imageKey = receiptToShow.dateReceived_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 3:
                cell.detailLabel.text = receiptToShow.paymentDueDate
                let imageKey = receiptToShow.paymentDueDate_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            case 4:
                cell.detailLabel.text = receiptToShow.other
                let imageKey = receiptToShow.other_ImagePath
                if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
                    cell.theImage?.image = imageStore.imageForKey( imageKey )
                }
            default:
                cell.detailLabel.text = " "
            }
        }
       */
       // if( (imageKey != "No Description") || (imageKey != "no entry") || (imageKey != nil)  ){
       //     cell.theImage?.image = imageStore.imageForKey( imageKey )
       // }
        //cell.detailLabel =
        return cell
        
    }
    
    func loadNewScreen(controller: UIViewController) {
        self.presentViewController(controller, animated: true) { () -> Void in
            
        };
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //self.rowIndex = indexPath
        //self.performSegueWithIdentifier("toDetail", sender: self)
        
        
    }
    
    func numberOfSections(tableView: UITableView)->Int{
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection: Int)->Int{
        return  12 //data.getQuestions()[pageIndex].count
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
        //!isLoadingMore &&
        if (maximumOffset - contentOffset <= threshold) {
            NSLog("!!!!!!!!!User got to bottom of table!!!!!!!!!")
            self.submitButton.enabled = true
            self.submitButton.alpha = 1.0
        }else{
            self.submitButton.enabled = false
            self.submitButton.alpha = 0.5
        }
    }
    
    ///only runs in portrait
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }
    
    /////////////////////////
    ///
    ///    Export to excel
    ///
    ////////////////////////
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        print("pressed yo")
        printDicts()
        
        
        /// important!! - saves the receipts to the database
        self.database.insertReceiptData()
        
        //saveTextToDatabase()
        
        //savePicsToDatabase()
        
        if !MFMailComposeViewController.canSendMail() {
            mailError()
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        
        //composeVC.setToRecipients(["catpicsapp@yahoo.com"])
        composeVC.setSubject("Shipment Summary")
        
        let emailDataString = createEmailString()
        composeVC.setMessageBody("Hello, \n\n Here is the shipment summary:\n\n\(emailDataString)\n\n Here is a csv containing the info", isHTML: false)
        
        // set up excel file
        
        let fileName = "ShipmentSummary.csv"
        
        let path = createCSVString(fileName)
        
        
        
        ///
        ///  set up email
        ///
        
        composeVC.addAttachmentData(NSData(contentsOfURL: path)!, mimeType: "text/csv", fileName: fileName)
        
        ///
        /// add pictures
        ///
        //let picdata = UIImagePNGRepresentation(data.imageDictionary[1000]!);
        //let filename = "UserPicture.png"
        //composeVC.addAttachmentData( picdata!, mimeType: "image/png", fileName: filename)
        
        for item in data.imageDictionary {
            let picdata = UIImagePNGRepresentation(item.1);
            let filename = "\(fieldDict[item.0]!).png"
            composeVC.addAttachmentData( picdata!, mimeType: "image/png", fileName: filename)
        }
        
        
        // Present the view controller modally.
        self.presentViewController(composeVC, animated: true, completion: nil)
        
        // after email is sent
        
        // self.performSegueWithIdentifier("backToStart", sender: self)
        
    }
    
    func savePicsToDatabase(){
        for item in data.imageDictionary {
            let picdata = UIImagePNGRepresentation(item.1);
            //let filename = "\(fieldDict[item.0]!).png"
            //composeVC.addAttachmentData( picdata!, mimeType: "image/png", fileName: filename)
        }
    }
    
    func saveTextToDatabase(){
        
        
        var receiptInfo = [String]()
        
        for item in fieldDict {
            // if(key == 0){
            
            
            if(data.inputDictionary[item.0] != nil){
                
                
                print(item.0)
                //receiptInfo.append(data.inputDictionary[item.0]!)
                if data.imageDictionary[item.0] != nil{
                    //newLine = "\(fieldDict[item.0]!),\(data.inputDictionary[item.0]!),\(data.imageDictionary[item.0]!)\n"
                    //csvText.appendContentsOf(newLine)
                    receiptInfo.append(data.inputDictionary[item.0]!)
                }else{
                    //newLine = "\(fieldDict[item.0]!): \(data.inputDictionary[item.0]!),  \n"
                    
                    //csvText.appendContentsOf(newLine)
                    receiptInfo.append(" ")
                }
                
            }else{
                receiptInfo.append(" ")
            }
            
            
        }
        
        
        
        print("before insert")
        
        print(receiptInfo)
        //self.database.insertReceiptData(receiptInfo)
        print("after insert")
        
        
    }
    
    
    
    func createEmailString() -> String {
        
        
        var emailText = ""//"Field,Decription,Picture\n"
        //var csvText = "Field,Decription,Picture\n"
        
        if NSUserDefaults.standardUserDefaults().valueForKey("businessName") != nil{
            let newLine = "Business Name: \(NSUserDefaults.standardUserDefaults().valueForKey("businessName")!)  \n"
            emailText.appendContentsOf(newLine)
        }else{
            let newLine = "Business Name:    \n"
            emailText.appendContentsOf(newLine)
        }
        
        if NSUserDefaults.standardUserDefaults().valueForKey("facilityAddress") != nil{
            let newLine = "Facility Address: \(NSUserDefaults.standardUserDefaults().valueForKey("facilityAddress")!)  \n"
            emailText.appendContentsOf(newLine)
        }else{
            let newLine = "Facility Address:    \n"
            emailText.appendContentsOf(newLine)
        }
        
        if NSUserDefaults.standardUserDefaults().valueForKey("userPhoneNumber") != nil{
            let newLine = "User Phone Number: \(NSUserDefaults.standardUserDefaults().valueForKey("userPhoneNumber")!) \n"
            emailText.appendContentsOf(newLine)
        }else{
            let newLine = "User Phone Number:   \n"
            emailText.appendContentsOf(newLine)
        }
        
        if NSUserDefaults.standardUserDefaults().valueForKey("userEmailAddress") != nil{
            let newLine = "User Email Address: \(NSUserDefaults.standardUserDefaults().valueForKey("userEmailAddress")!) \n"
            emailText.appendContentsOf(newLine)
        }else{
            let newLine = "User Email Address:   \n"
            emailText.appendContentsOf(newLine)
        }
        
        if NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsName") != nil{
            let newLine = "User Supervisors Name: \(NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsName")!) \n"
            emailText.appendContentsOf(newLine)
        }else{
            let newLine = "User Supervisors Name:   \n"
            emailText.appendContentsOf(newLine)
        }
        
        if NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsEmail") != nil{
            let newLine = "User Supervisors Email: \(NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsEmail")!) \n"
            emailText.appendContentsOf(newLine)
        }else{
            let newLine = "User Supervisors Email:  \n"
            emailText.appendContentsOf(newLine)
        }
        
        
        for item in fieldDict {
            // if(key == 0){
            
            var newLine = ""
            
            if(data.inputDictionary[item.0] != nil){
                
                
                print(item.0)
                
                // if data.imageDictionary[item.0] != nil{
                //    newLine = "\(fieldDict[item.0]!),\(data.inputDictionary[item.0]!),\(data.imageDictionary[item.0]!)\n"
                //csvText.appendContentsOf(newLine)
                ///}else{
                newLine = "\(fieldDict[item.0]!): \(data.inputDictionary[item.0]!),  \n"
                //csvText.appendContentsOf(newLine)
                // }
                
            }else{
                newLine = "\(fieldDict[item.0]!):    \n"
            }
            
            emailText.appendContentsOf(newLine)
            
        }
        
        return emailText
    }
    
    func createCSVString(fileName:String ) -> NSURL {
        
        
        
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).URLByAppendingPathComponent(fileName)
        
        var emailText = "Field,Decription,Picture\n"
        var csvText = "Field,Decription,Picture\n"
        
        if NSUserDefaults.standardUserDefaults().valueForKey("businessName") != nil{
            let newLine = "Business Name,\(NSUserDefaults.standardUserDefaults().valueForKey("businessName")!),  \n"
            let emailLine = "Business Name: \(NSUserDefaults.standardUserDefaults().valueForKey("businessName")!),  \n"
            csvText.appendContentsOf(newLine)
            emailText.appendContentsOf(emailLine)
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("facilityAddress") != nil{
            let newLine = "Facility Address,\(NSUserDefaults.standardUserDefaults().valueForKey("facilityAddress")!),  \n"
            csvText.appendContentsOf(newLine)
            
        }
        //if let pictureOfUser = NSUserDefaults.standardUserDefaults().valueForKey("pictureOfUser"){
        //    let newLine = "Picture Of User,\(NSUserDefaults.standardUserDefaults().valueForKey("pictureOfUser")), \n"
        //     csvText.appendContentsOf(newLine)
        // }
        if NSUserDefaults.standardUserDefaults().valueForKey("userPhoneNumber") != nil{
            let newLine = "User Phone Number,\(NSUserDefaults.standardUserDefaults().valueForKey("userPhoneNumber")!), \n"
            csvText.appendContentsOf(newLine)
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("userEmailAddress") != nil{
            let newLine = "User Email Address,\(NSUserDefaults.standardUserDefaults().valueForKey("userEmailAddress")!), \n"
            csvText.appendContentsOf(newLine)
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsName") != nil{
            let newLine = "User Supervisors Name,\(NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsName")!), \n"
            csvText.appendContentsOf(newLine)
        }
        if NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsEmail") != nil{
            let newLine = "User Supervisors Email,\(NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsEmail")!), \n"
            csvText.appendContentsOf(newLine)
        }
        // let fieldDict = [[0:"Goods Description"],[1:"Location Recieved"],[2:"PO#"],[3:"Weight"],[4:"BOL# Description"],[10:"Rebate"],[11:"Cost"],[12:"Date Recieved"],[13:"Payment Due Date"],[14:"Goods Description"],[15:"Goods Description"]]
        
        
        
        for item in fieldDict {
            // if(key == 0){
            
            var newLine = ""
            
            if(data.inputDictionary[item.0] != nil){
                
                
                print(item.0)
                
                if data.imageDictionary[item.0] != nil{
                    newLine = "\(fieldDict[item.0]!),\(data.inputDictionary[item.0]!),\(data.imageDictionary[item.0]!)\n"
                    //csvText.appendContentsOf(newLine)
                }else{
                    newLine = "\(fieldDict[item.0]!),\(data.inputDictionary[item.0]!),  \n"
                    //csvText.appendContentsOf(newLine)
                }
                
            }else{
                newLine = "\(fieldDict[item.0]!),  ,  \n"
            }
            
            csvText.appendContentsOf(newLine)
            
        }
        
        do {
            try csvText.writeToURL(path!, atomically: true, encoding: NSUTF8StringEncoding)
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
        return path!
    }
    
    /////
    //
    //   mail stuff
    //
    ////////
    
    func mailError(){
        let alertController = UIAlertController(title: "Error", message: "Cannot send email. Please set up the deafault mail app", preferredStyle: .Alert)
        let actionOk = UIAlertAction(title: "OK",
                                     style: .Default,
                                     handler: nil) //You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch result.rawValue {
        case MFMailComposeResult.Cancelled.rawValue:
            print("Mail cancelled")
        case MFMailComposeResult.Saved.rawValue:
            print("Mail saved")
        case MFMailComposeResult.Sent.rawValue:
            print("Mail sent")
            self.mailSent = true
        case MFMailComposeResult.Failed.rawValue:
            print("Mail sent failure: \(error!.localizedDescription)")
        default:
            break
        }
        controller.dismissViewControllerAnimated(true, completion: nil)
        if(mailSent){
            self.performSegueWithIdentifier("backToStart", sender: self)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            //imageView.contentMode = .ScaleAspectFit
            
            let attatchedImage = pickedImage
            //self.imageData = UIImagePNGRepresentation(attatchedImage)
            
            dismissViewControllerAnimated(true, completion: nil)
            attatchmentEmail()
        }
        
        
        
    }
    
    func attatchmentEmail()  {
        if !MFMailComposeViewController.canSendMail() {
            mailError()
            print("Mail services are not available")
            return
        }
        
        let composeVC = MFMailComposeViewController()
        composeVC.mailComposeDelegate = self
        
        // Configure the fields of the interface.
        //composeVC.setToRecipients(["catpicsapp@yahoo.com"])
        composeVC.setSubject("Shipment Summary")
        composeVC.setMessageBody("Hello, \n here is a csv containing the info", isHTML: false)
        
        // add attatchment
        //composeVC.addAttachmentData(imageData!, mimeType: "text/csv", fileName: "ShipmentSummary.csv")
        
        // Present the view controller modally.
        self.presentViewController(composeVC, animated: true, completion: nil)
        
    }
    
    
}

