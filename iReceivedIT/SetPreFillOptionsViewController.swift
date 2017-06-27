//
//  SetPreFillOptionsViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/1/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//
 
import Foundation

class SetPreFillOptionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    var optionPrefill:String! = nil
    
    var textView:UITextView! = nil
    
    var database = DBManager.shared
    
    var keyboardCount = 0
    
    var fieldTag = 0
    
    var currentlyEditing = false
    
    //@IBOutlet var editTextView: UITextView!
    @IBOutlet var addPrefilButton: UIBarButtonItem!
    @IBOutlet var navigationBar: UINavigationBar!
    
    @IBOutlet var tableView: UITableView!
    @IBAction func addPrefillButtonPressed(sender: AnyObject) {
        print("stuff")
        showAlert()
    }
    
    //var options = ["stuff", "other stuff", "more stuff"]
    
    //var options = [" ", " ", " ", " ", " ", " ", " "]//[String]()
    
    var options = [String]()
    
    var prefillColumns: [String: String] = [:]

    func showAlert() {
        
        let alertController = UIAlertController(title: "Edit Prefill",
                                                message: "Please enter a prefil option for \(optionPrefill)",preferredStyle: .Alert)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        alertController.addTextFieldWithConfigurationHandler({ (textField) in
            textField.placeholder = "Enter \(self.optionPrefill)"
        })
        
        
        let favoriteAction = UIAlertAction(title: "Save prefill option", style: .Default,
                                           handler: { (action) -> Void in
                                            
                                            print("lol cats")
                                            
                                            //Read user input
                                            let userInput:String
                                            if let textField = alertController.textFields![0] as? UITextField{
                                                if(!(textField.text?.isEmpty)!){
                                                    userInput = textField.text!
                                                }else {
                                                    userInput = " "
                                                }
                                            }
                                            else {
                                                userInput = " "
                                            }
                                            
                                            print(userInput)
                                            /*
                                            let currentPic = currentViewController.catImage.image
                                            
                                            let item = self.itemStore.createItem(userTitle, pic:currentPic!)
                                            let imageKey = item.itemKey
                                            
                                            self.imageStore.setImage(currentPic!, forKey: imageKey )
                                            
                                            print(imageKey)
                                            print(self.itemStore.allItems.count)
                                            */
                                            //print("num favs: \(self.imageStore.getFavoritesCount())")
                                            
                                            
                                            
                                            self.options.append(userInput)
                                            
                                            self.saveToDatabase(userInput)
                                            
                                            self.tableView.reloadData()
        })
        alertController.addAction(favoriteAction)
        
        
      self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    
    //let options = ["Goods Description","Location Received","PO#","Weight","BOL#","Rebate","Cost","Date Received","Payment Due Date","Other"]
    
    
    override func viewDidLoad() {
        //navigationBar.
        print("the page is at: ")
        print(optionPrefill)
        print("the page has \(options.count) entries")
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //textView.delegate = self
        
        self.navigationBar.topItem?.title = optionPrefill
        self.addPrefilButton.tintColor = UIColor.clearColor()//.hidden = true
        
        
        
        
        let entryNumber = database.field_Prefill_EntryNumber
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
        
        //prefillColumns = ["Goods Description" : goodsDescription,"Location Received" : locationReceived,"PO#" : pONumber, "Weight" : weight, "BOL#" : bOLNuber, "Rebate" : rebate , "Cost" : cost, "Date Received" : dateReceived , "Payment Due Date" : paymentDueDate , "Other" : other]
        
        prefillColumns = ["Entry Number" : entryNumber, "Receiving Location" : goodsDescription, "Supplier" : locationReceived,"PO Number" : pONumber, "BOL Number" : weight, "Trailer/Truck Number" : bOLNuber, "Material Description" : rebate , "Weight" : cost, "UOM" : dateReceived , "Cost" : paymentDueDate , "Rebate" : other, "Payment Amount" : plusOne, "Payment Due Date": plusTwo] //, "Rebate" : other]
        
        //options = [" ", " ", " ", " ", " ", " "]
       
        loadFromDatabase()
        
        //self.tableView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //loadCurrentUser()
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    func firstSaveToDatabase(){
        
        let prefillColumn = prefillColumns[optionPrefill]
        //print("lets see whats at: \(prefillColumn)")
        let key = NSUUID().UUIDString
        let toInsert = [" "," "," "," "," "," "," "] //,"",""]
        database.insertPrefillData(toInsert, prefillColumn: prefillColumn!)
        
    }
    
    func saveToDatabase(thenewRecord:String){
        
        let prefillColumn = prefillColumns[optionPrefill]
        //print("lets see whats at: \(prefillColumn)")
        
        let toInsert = [thenewRecord]
        database.insertPrefillData(toInsert, prefillColumn: prefillColumn!)
        
    }
    
    func updateDatabase(thenewRecord:String, index:Int){
        
        let prefillColumn = prefillColumns[optionPrefill]
        //print("lets see whats at: \(prefillColumn)")
        self.options[index] = thenewRecord
        let toInsert = [thenewRecord]
        
        database.updatePrefillData(self.options, prefillColumn: prefillColumn!)
        
        //database.updatePrefillData(thenewRecord, prefillColumn: prefillColumn!, index: index)

    }
    
    func loadFromDatabase(){
        print("load data called")
        let prefillColumn = prefillColumns[optionPrefill]
        
        if(database.loadPrefill(prefillColumn!) != nil){
            options = database.loadPrefill(prefillColumn!)
        }
        
        if( options.count == 0 ){ //database.loadPrefill(prefillColumn!) == nil){
            print("this should only be called on first opening of table")
            firstSaveToDatabase()
            options = database.loadPrefill(prefillColumn!)
            print("options is now \(options)")
            self.tableView.reloadData()
        }else{
            print("\(prefillColumn) column is")
            options = database.loadPrefill(prefillColumn!)
            print(options)
            print("database loaded")
        }
        /*
        if( database.loadPrefill(prefillColumn!) != nil && options.count != 0){
            print("\(prefillColumn) column is")
            options = database.loadPrefill(prefillColumn!)
            print(options)
            print("database loaded")
        }else{
            print("this should only be called on first opening of table")
            firstSaveToDatabase()
            options = database.loadPrefill(prefillColumn!)
            print("options is now \(options)")
            self.tableView.reloadData()
        }*/
        let rows = database.loadPrefillRowNumbers()
        print("the freaking rows are \(rows)")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count //6//userStore.user.count
    }
    
    
    func tableView(tableView: UITableView,
                   cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = self.tableView!.dequeueReusableCellWithIdentifier("editPrefillCell") as! EditPrefillCell
        print("new cell \(cell)")
        //cell.textLabel?.text = options[indexPath.row]
        print("text is: \(options[indexPath.row]) -end")
        
        cell.prefillTextField.text = options[indexPath.row]
        cell.prefillTextField?.delegate = self
        cell.prefillTextField.layer.borderWidth = 1
        cell.prefillTextField.layer.borderColor = UIColor.grayColor().CGColor //] CGColor];
        cell.prefillTextField.layer.cornerRadius = 5
        cell.prefillTextField.tag = indexPath.row
        cell.optionPrefill = optionPrefill
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    ////////////////
    ///
    ///   Keyboard
    ///
    ////////////////
    
    //dissmis keyboard when tapped outside of the keyboard area
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event:UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textViewShouldReturn(textField: UITextView) -> Bool{
        textField.resignFirstResponder()
        return true
    }

    
    func textViewShouldBeginEditing(textField: UITextView) -> Bool {
        NSLog("should begin editing now")
        return true
    }
    
    
    func textViewShouldEndEditing(textField: UITextView) -> Bool {
        NSLog("should end editing now")
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView){
        NSLog("end editing now")
        NSLog("entered value is %@", textView.text!)
        //let key = (pageIndex * 100) + pageRow
        //data.inputDictionary.updateValue(textField.text!, forKey:key)
        //cell = self.tableView.cellForRowAtIndexPath( NSIndexPath(forRow: textField.tag, inSection: 0) ) as! InputCell
        //let  key = (index * 100) + row
        
        let userInput = textView.text
        print("saving \(userInput) to \(textView.text)")
        self.updateDatabase(userInput, index: textView.tag)
        print("\(options)")
        //updateStringDictionary(textView.text!, dictKey: key)
    }
    
    //////
    ///  fix the keyboard covering things issue
    //////
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        print("begin editing yo")
        fieldTag = textView.tag
        //currentField = textField
        //print(fieldTag)
        print("the actual when begin editing value: \(fieldTag) ")
        //currentTextField = textField
        
    }
    
    func getKeyboardHeight(notification: NSNotification)  -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func keyboardWillShow(notification: NSNotification){
        //print("the value: self.currentTextField!.tag")
        //fieldTag = self.currentTextField!.tag
        //print(self.currentTextField!.tag)
        //print(fieldTag)
        print("WillShow the actual value will show: \(fieldTag) ")
        print("WillShow keyboard up?: \(self.currentlyEditing) ")
        if(currentlyEditing == false ){
            if(fieldTag >= 4 && fieldTag < 6 ){
                self.view.frame.origin.y -= (2*getKeyboardHeight(notification)/3)
                currentlyEditing = true
            }
            if(fieldTag >= 6 ){
                self.view.frame.origin.y -= (getKeyboardHeight(notification))
                currentlyEditing = true
            }
            /*
            if ( (currentField == userEmailAddressField )  ){
                // move view accordingly
                //if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= (2.2*getKeyboardHeight(notification)/3)
                currentlyEditing = true
                // }
            }
            else if ( (currentField == userSupervisorsNameField )  ){
                // move view accordingly
                //if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= (2.2*getKeyboardHeight(notification)/3)
                currentlyEditing = true
                // }
            }
            else if( (currentField == userSupervisorsEmailField ) ){
                //if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= (2.6*getKeyboardHeight(notification)/3)
                currentlyEditing = true
                // }
            }
            */
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        //print(fieldTag)
        print("WillHide the actual value will hide: \(fieldTag) ")
        print("WillHide keyboard up?: \(self.currentlyEditing) ")
        //if (  (currentField == supportField ) || (currentField == jobsiteField ) ) {
        
        /*
         if(currentlyEditing == true ){
         if ( (currentField == supportField )  ){
         // if(self.view.frame.origin.y != 0){
         self.view.frame.origin.y += (getKeyboardHeight(notification)/2)
         currentlyEditing = false
         // }
         }
         else if( (currentField == jobsiteField ) ){
         //if(self.view.frame.origin.y != 0){
         self.view.frame.origin.y += (getKeyboardHeight(notification)/2)
         currentlyEditing = false
         //}
         }
         }else
         */
        print("WillHide origin pos: \(self.view.frame.origin.y)" )
        if(self.view.frame.origin.y != 0){
            self.view.frame.origin.y = 0// += (getKeyboardHeight(notification)/2)
            currentlyEditing = false
        }
        
    }
    
    func subscribeToKeyboardNotifications(){
        print("did the keyboard show?")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillShow), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(keyboardWillHide), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    ///only runs in portrait
    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.Portrait
    }


}
