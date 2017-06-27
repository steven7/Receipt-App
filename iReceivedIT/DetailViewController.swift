//
//  DetailViewController.swift
//  iReceivedIT
//
//  Created by Steven Kanceruk on 10/28/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, UINavigationControllerDelegate,UITextViewDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var takePhotoButton: UIButton!
    @IBOutlet var submitButton: UIButton!
    var index:Int = 0
    var row:Int = 0
    var key = 0//String((index * 100) + row)
    let data = QuestionStore.sharedInstance
    var database = DBManager.shared
    
    //var item: Item! {
    //    didSet{
    //        navigationItem.title = item.name
    //    }
    //}
    /*
    var fieldDict: [Int :String] = [
        0:"Goods Description",
        1:"Location Received",
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
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        performSegueWithIdentifier("goBack", sender: self)
    }
    
    var imageStore: ImageStore!
    
    @IBOutlet var descriptionTextView: UITextView!
    //@IBOutlet var theImage: UIImageView!
    
    override func viewDidLoad() {
        self.descriptionTextView.delegate = self
        //self.descriptionTextView.placeholderTExt
        self.navigationController?.navigationBar.hidden = false
        updateFieldFromDict()
        updateImageFromDict()
        self.submitButton.layer.borderWidth = 1
        let greenColor = UIColor(hexString: "63FF7A")
        self.submitButton.layer.borderColor = greenColor.CGColor
        self.submitButton.backgroundColor = UIColor.whiteColor()
        print("the key for this page is now : String((\(index) * 100) + \(row))")
        //let key = (index * 100) + row
        self.titleLabel.text = fieldDict[key]
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if(database.carryover_Prefill != nil){
            descriptionTextView.text = database.carryover_Prefill
            //let  key = (index * 100) + row
            updateStringDictionary(database.carryover_Prefill, dictKey: key)
            database.carryover_Prefill = nil
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if the triggered segue is the "showitem" segue
        if segue.identifier == "toAutofill"{
            let detailViewController
                = segue.destinationViewController as! AutoFillOptionsViewController
            //let key = (index * 100) + row
            detailViewController.optionPrefill = fieldDict[key]
            
        }
    }
    
    @IBAction func takePicture(sender: UIBarButtonItem) {
        
        let imagePicker = UIImagePickerController()
        
        // IF the device has a camera, take a picture; otherwise
        // just pick from photo library
        if UIImagePickerController.isSourceTypeAvailable(.Camera){
            imagePicker.sourceType = .Camera
        }
        else{
            imagePicker.sourceType = .PhotoLibrary
        }
        
        imagePicker.delegate = self
        
        // Place image picker on the screen
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        // Get picked image from info dictionary
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        //let key = (index * 100) + row
        print("this is the key - \(key)")
        
        // Store image in the ImageStore for the item's key
        
        
        //imageStore.setImage(image, forKey: key)
        data.imageDictionary.updateValue(image, forKey:key)
        
        // put that image on the screen in the image view
        //theImage.image = image
        takePhotoButton.setImage(image, forState: .Normal)
        
        //take picker off screen
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    ////////
    ///
    /// text field stuff
    ///
    ////////
    
    // load stored data if any 
    
    func updateFieldFromDict(){
        //let  key = (index * 100) + row
        if data.inputDictionary[key] != nil{
            //segementedControl.setEnabled(true, forSegmentAtIndex: key)
            //okSwitch.on = true
            if data.inputDictionary[key] != " "{
                descriptionTextView.text = data.inputDictionary[key]
                print("was already on with value \(data.inputDictionary[key])")
            }
        }else{
            data.inputDictionary.updateValue(" ", forKey:key)
            print("was not already on the field was")
        }
    }
    
    func updateImageFromDict(){
        //key = (pageIndex * 100) + pageRow
        if (data.imageDictionary[key] != nil) {// && (data.imageDictionary[key] != UIImage(named: "Placeholder") && (data.imageDictionary[key] != UIImage(named: "Placeholder")) ) {
            //segementedControl.setEnabled(true, forSegmentAtIndex: key)
            //okSwitch.on = true
            print("the cell has key and a saved image jjj \(key)")
          //  if data.imageDictionary[key] != nil{
            //let imageKey = data.imageDictionary[key]
            //self.theImage.image = data.imageDictionary[key]//imageStore.imageForKey( imageKey )
            self.takePhotoButton.setImage(data.imageDictionary[key], forState: .Normal)
            print("\(key) was already on with value \(data.imageDictionary[key])")
          //  }
        }else{
            //self.theImage.image = UIImage(named: "Placeholder")
            print("the cell has key \(key)")
            print("!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
            //data.imageDictionary.updateValue(nil, forKey:key)
            //print("was not already on the field was")
        }
    }
    
    /*
    func updateImageFromDict(){
        //let  key = (index * 100) + row
        //if data.inputDictionary[key] != nil{
            //segementedControl.setEnabled(true, forSegmentAtIndex: key)
            //okSwitch.on = true
            if data.imageDictionary[key] != nil{
                self.theImage.image = data.imageDictionary[key]
                print("was already on with value \(data.inputDictionary[key])")
        }else{
           print("why no pic?")
        }
        //}else{
            //data.imageDictionary.updateValue(nil, forKey:key)
            //print("was not already on the field was")
        //}
    }
    */
    
    ////////
    //dissmis keyboard when tapped outside of the keyboard area
    override func touchesBegan(touches: Set<UITouch>, withEvent event:UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func textViewShouldReturn(textField: UITextView) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView){
        NSLog("end editing now")
        NSLog("entered value is %@", textView.text!)
        //let key = (pageIndex * 100) + pageRow
        //data.inputDictionary.updateValue(textField.text!, forKey:key)
        //cell = self.tableView.cellForRowAtIndexPath( NSIndexPath(forRow: textField.tag, inSection: 0) ) as! InputCell
        //let  key = (index * 100) + row
        updateStringDictionary(textView.text!, dictKey: key)
    }
    
    func updateStringDictionary(inputString: String, dictKey:Int){
        if(inputString != ""){
            data.inputDictionary.updateValue(inputString, forKey:dictKey)
        }else{
            data.inputDictionary.updateValue(" ", forKey:dictKey)
        }
    }
    
}
