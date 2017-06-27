//
//  CreateUserProfileViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/1/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import Foundation
//import CoreData

class CreateUserProfileViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    
    @IBOutlet weak var createbusinessNameField:UITextField!
    @IBOutlet weak var createfacilityAddressField:UITextField!
    
    @IBOutlet weak var createpictureOfUserButton:UIButton!
    @IBOutlet weak var createtinyImage: UIImageView!
    
    @IBOutlet weak var createuserPhoneNumberField:UITextField!
    @IBOutlet weak var createuserEmailAddressField:UITextField!
    @IBOutlet weak var createuserSupervisorsNameField:UITextField!
    @IBOutlet weak var createuserSupervisorsEmailField:UITextField!
    @IBOutlet weak var saveButton:UIButton!
    
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    
    @IBAction func rightBarButtonPressed(sender: AnyObject) {
        buttonPressed()
    }
    
    var fieldTag = 0
    var currentField:UITextField!
    let techInfo = NSUserDefaults.standardUserDefaults()
    var keyboardCount = 0
    var currentlyEditing = false
    var userName:String = " "
    var businessName:String = " "
    var facilityAddress:String = " "
    var tinyImagePath: String = " "
    var userPhoneNumber:String = " "
    var userEmailAddress:String  = " "
    var userSupervisorsName:String = " "
    var userSupervisorsEmail:String = " "
    
    var currentUser:User!
    
    let userKey: String = " "
    
    var database = DBManager.shared
    
    var userInfo = [String]()
    
    //super useful singleton classes
    let data = QuestionStore.sharedInstance
    let imageStore = ImageStore.sharedInstance
    
  
    var tinyImage:UIImage!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        buttonBorders()
        
        createbusinessNameField.delegate = self
        createfacilityAddressField.delegate = self
        createuserPhoneNumberField.delegate = self
        createuserEmailAddressField.delegate = self
        createuserSupervisorsNameField.delegate = self
        createuserSupervisorsEmailField.delegate = self
        
        diffIfOnIphone5()
        
    }
    
    func diffIfOnIphone5(){
        if UIDevice().userInterfaceIdiom == .Phone {
            if (UIScreen.mainScreen().nativeBounds.height == 1136 ){
                
                print("iPhone 5 or 5S or 5C")
                saveButton.enabled = false
                saveButton.hidden = true
                rightBarButton.enabled = true
                //rightBarButton.tintColor = UIColor.clearColor()
                
            }else{
                print("is NOT iPhone 5 or 5S or 5C")
                rightBarButton.enabled = false
                //rightBarButton.tintColor
                rightBarButton.tintColor = UIColor.clearColor()
                saveButton.enabled = true
                saveButton.hidden = false
            }
        }else{
            print("is NOT iPhone 5 or 5S or 5C")
            rightBarButton.enabled = false
            //rightBarButton.tintColor
            rightBarButton.tintColor = UIColor.clearColor()
            saveButton.enabled = true
            saveButton.hidden = false
        }
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        
        print("coming soon!!")
        
        //var userName:String
        
        if(createbusinessNameField.text !=  ""){
            self.businessName = createbusinessNameField.text!
            userInfo.append(businessName)
        }else{
            self.businessName = " "//"not entered"
            userInfo.append(businessName)
        }
        if(createfacilityAddressField.text !=  ""){
            self.facilityAddress = createfacilityAddressField.text!
            userInfo.append(facilityAddress)
        }else{
            self.facilityAddress = " "//"not entered"
            userInfo.append(facilityAddress)
        }
        //if(createbusinessNameField.text != nil){
        //    self.tinyImagePath = createbusinessNameField.text
        //}
        
        if let image = createtinyImage.image {
            self.tinyImage = image
            //print("got image")
            //print(image)
            let imageKey = NSUUID().UUIDString
            //print(imageKey)
            imageStore.setImage(image, forKey: imageKey)
            userInfo.append(imageKey)
        }else{
            userInfo.append("no picture")
        }
        
        
        if(createuserPhoneNumberField.text != ""){
            self.userPhoneNumber = createuserPhoneNumberField.text!
            userInfo.append(userPhoneNumber)
        }else{
            self.userPhoneNumber = " "//"not entered"
            userInfo.append(userPhoneNumber)
        }
        if(createuserEmailAddressField.text != ""){
            self.userEmailAddress = createuserEmailAddressField.text!
            userInfo.append(userEmailAddress)
        }else{
            self.userEmailAddress = " "//"not entered"
            userInfo.append(userEmailAddress)
        }
        if(createuserSupervisorsNameField.text != ""){
            self.userSupervisorsName = createuserSupervisorsNameField.text!
            userInfo.append(userSupervisorsName)
        }else{
            self.userSupervisorsName = " "//"not entered"
            userInfo.append(userSupervisorsName)
        }
        if(createuserSupervisorsEmailField.text !=  ""){
            self.userSupervisorsEmail = createuserSupervisorsEmailField.text!
            userInfo.append(userSupervisorsEmail)
        }else{
            self.userSupervisorsEmail = " "//"not entered"
            userInfo.append(userSupervisorsEmail)
        }
     
        
        userName = "Bill Clinton"
        userInfo.append(userSupervisorsEmail)
        
        print("\(businessName)")
        print("\(facilityAddress)")
        
        print("\(tinyImagePath)")
        
        print("\(userPhoneNumber)")
        print("\(userEmailAddress)")
        print("\(userSupervisorsName)")
        print("\(userSupervisorsEmail)")
        
        
        print("before insert")
        self.database.insertUserData(userInfo)
        print("after insert")
        
        
        
        let alertController = UIAlertController(title: "User Saved!", message: "This user is now saved and set as the current user", preferredStyle: .Alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "OK",
                                      style: .Default,
                                      handler: {(alert :UIAlertAction!) in
                                        print("YOU PRESSED OK")
                                        self.performSegueWithIdentifier("toStart", sender: self)
                                        //self.navigationController?.popToRootViewControllerAnimated(true)
        }) //You can use a block here to handle a press on this button
         
        alertController.addAction(actionOk)
         
        presentViewController(alertController, animated: true, completion: nil)
        
        //buttonPressed()
    }
    
    func buttonPressed(){
        
        
        //var userName:String
        
        if(createbusinessNameField.text !=  ""){
            self.businessName = createbusinessNameField.text!
            userInfo.append(businessName)
        }else{
            self.businessName = " "//"not entered"
            userInfo.append(businessName)
        }
        if(createfacilityAddressField.text !=  ""){
            self.facilityAddress = createfacilityAddressField.text!
            userInfo.append(facilityAddress)
        }else{
            self.facilityAddress = " "//"not entered"
            userInfo.append(facilityAddress)
        }
        //if(createbusinessNameField.text != nil){
        //    self.tinyImagePath = createbusinessNameField.text
        //}
        
        if let image = createtinyImage.image {
            self.tinyImage = image
            //print("got image")
            //print(image)
            let imageKey = NSUUID().UUIDString
            //print(imageKey)
            imageStore.setImage(image, forKey: imageKey)
            userInfo.append(imageKey)
        }else{
            userInfo.append("no picture")
        }
        
        
        if(createuserPhoneNumberField.text != ""){
            self.userPhoneNumber = createuserPhoneNumberField.text!
            userInfo.append(userPhoneNumber)
        }else{
            self.userPhoneNumber = " "//"not entered"
            userInfo.append(userPhoneNumber)
        }
        if(createuserEmailAddressField.text != ""){
            self.userEmailAddress = createuserEmailAddressField.text!
            userInfo.append(userEmailAddress)
        }else{
            self.userEmailAddress = " "//"not entered"
            userInfo.append(userEmailAddress)
        }
        if(createuserSupervisorsNameField.text != ""){
            self.userSupervisorsName = createuserSupervisorsNameField.text!
            userInfo.append(userSupervisorsName)
        }else{
            self.userSupervisorsName = " "//"not entered"
            userInfo.append(userSupervisorsName)
        }
        if(createuserSupervisorsEmailField.text !=  ""){
            self.userSupervisorsEmail = createuserSupervisorsEmailField.text!
            userInfo.append(userSupervisorsEmail)
        }else{
            self.userSupervisorsEmail = " "//"not entered"
            userInfo.append(userSupervisorsEmail)
        }
        
        
        userName = "Bill Clinton"
        userInfo.append(userSupervisorsEmail)
        
        print("\(businessName)")
        print("\(facilityAddress)")
        
        print("\(tinyImagePath)")
        
        print("\(userPhoneNumber)")
        print("\(userEmailAddress)")
        print("\(userSupervisorsName)")
        print("\(userSupervisorsEmail)")
        
        
        print("before insert")
        self.database.insertUserData(userInfo)
        print("after insert")
        
        
        
        let alertController = UIAlertController(title: "User Saved!", message: "This user is now saved and set as the current user", preferredStyle: .Alert)
        //We add buttons to the alert controller by creating UIAlertActions:
        let actionOk = UIAlertAction(title: "OK",
                                     style: .Default,
                                     handler: {(alert :UIAlertAction!) in
                                        print("YOU PRESSED OK")
                                        self.performSegueWithIdentifier("toStart", sender: self)
                                        //self.navigationController?.popToRootViewControllerAnimated(true)
        }) //You can use a block here to handle a press on this button
        
        alertController.addAction(actionOk)
        
        presentViewController(alertController, animated: true, completion: nil)
        

    }
    
    func saveToDatabase(){
        
        
        
        //var userName:String
        
        if(createbusinessNameField.text !=  ""){
            self.businessName = createbusinessNameField.text!
            userInfo.append(businessName)
        }else{
            self.businessName = " "//"not entered"
            userInfo.append(businessName)
        }
        if(createfacilityAddressField.text !=  ""){
            self.facilityAddress = createfacilityAddressField.text!
            userInfo.append(facilityAddress)
        }else{
            self.facilityAddress = " "//"not entered"
            userInfo.append(facilityAddress)
        }
        //if(createbusinessNameField.text != nil){
        //    self.tinyImagePath = createbusinessNameField.text
        //}
        
        if let image = createtinyImage.image {
            self.tinyImage = image
            //print("got image")
            //print(image)
            let imageKey = NSUUID().UUIDString
            //print(imageKey)
            imageStore.setImage(image, forKey: imageKey)
            userInfo.append(imageKey)
        }else{
            userInfo.append("no picture")
        }
        
        
        if(createuserPhoneNumberField.text != ""){
            self.userPhoneNumber = createuserPhoneNumberField.text!
            userInfo.append(userPhoneNumber)
        }else{
            self.userPhoneNumber = " "//"not entered"
            userInfo.append(userPhoneNumber)
        }
        if(createuserEmailAddressField.text != ""){
            self.userEmailAddress = createuserEmailAddressField.text!
            userInfo.append(userEmailAddress)
        }else{
            self.userEmailAddress = " "//"not entered"
            userInfo.append(userEmailAddress)
        }
        if(createuserSupervisorsNameField.text != ""){
            self.userSupervisorsName = createuserSupervisorsNameField.text!
            userInfo.append(userSupervisorsName)
        }else{
            self.userSupervisorsName = " "//"not entered"
            userInfo.append(userSupervisorsName)
        }
        if(createuserSupervisorsEmailField.text !=  ""){
            self.userSupervisorsEmail = createuserSupervisorsEmailField.text!
            userInfo.append(userSupervisorsEmail)
        }else{
            self.userSupervisorsEmail = " "//"not entered"
            userInfo.append(userSupervisorsEmail)
        }
        
        
        userName = "Bill Clinton"
        userInfo.append(userSupervisorsEmail)
        
        print("\(businessName)")
        print("\(facilityAddress)")
        
        print("\(tinyImagePath)")
        
        print("\(userPhoneNumber)")
        print("\(userEmailAddress)")
        print("\(userSupervisorsName)")
        print("\(userSupervisorsEmail)")
        
        
        print("before insert")
        self.database.insertUserData(userInfo)
        print("after insert")
        
        
    }
    
    
    func buttonBorders(){
        
        saveButton.layer.cornerRadius = 5
        saveButton.layer.borderWidth = 1
        let greenColor = UIColor(hexString: "63FF7A")
        saveButton.layer.borderColor = greenColor.CGColor
        self.view.tintColor.CGColor
        
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    ///////////////
    ///
    ///   Camera
    ///
    ////////////////
    
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
        
        let key = 1000 // this key is differnt
        print("this is the key - \(key)")
        
        // Store image in the ImageStore for the item's key
        //imageStore.setImage(image, forKey: key)
        data.imageDictionary.updateValue(image, forKey:key)
        
        // put that image on the screen in the image view
        createtinyImage.image = image
        
        //take picker off screen
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        NSLog("should begin editing now")
        return true
    }
    
    
    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
        NSLog("should end editing now")
        return true
    }
    
    ////////////////
    ///
    ///   save
    ///
    ////////////////
    
    func textFieldDidEndEditing(textField: UITextField){
        NSLog("end editing now")
        NSLog("entered value is %@", textField.text!)
        let defaults = NSUserDefaults.standardUserDefaults()
        if(fieldTag == 0 ){
            defaults.setObject(textField.text, forKey: "businessName")
        }
        else if(fieldTag == 1 ){
            defaults.setObject(textField.text, forKey: "facilityAddress")
            
        }
            
        else if(fieldTag == 2 ){
            defaults.setObject(textField.text, forKey: "userPhoneNumber")
            
        }
        else if(fieldTag == 3 ){
            defaults.setObject(textField.text, forKey: "userEmailAddress")
            
        }
        else if(fieldTag == 4 ){
            defaults.setObject(textField.text, forKey: "userSupervisorsName")
            
        }
        else if(fieldTag == 5 ){
            defaults.setObject(textField.text, forKey: "userSupervisorsEmail")
            
        }
    }
    
    
    ////////////////
    ///
    ///   Keyboard
    ///
    ////////////////
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        // if textField == inputText{
        //   text
        // }
        textField.resignFirstResponder()
        return true
    }
    
    //dissmis keyboard when tapped outside of the keyboard area
    override func touchesBegan(touches: Set<UITouch>, withEvent event:UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    
    //////
    ///  fix the keyboard covering things issue
    //////
    
    
    func textFieldDidBeginEditing(textField: UITextField) {
        print("begin editing yo")
        fieldTag = textField.tag
        currentField = textField
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
       
        print("WillShow the actual value will show: \(fieldTag) ")
        print("WillShow keyboard up?: \(self.currentlyEditing) ")
        if(currentlyEditing == false ){
            if ( (currentField == createuserEmailAddressField )  ){
                // move view accordingly
                //if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= (2.2*getKeyboardHeight(notification)/3)
                currentlyEditing = true
                // }
            }
            else if ( (currentField == createuserSupervisorsNameField )  ){
                // move view accordingly
                //if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= (2.2*getKeyboardHeight(notification)/3)
                currentlyEditing = true
                // }
            }
            else if( (currentField == createuserSupervisorsEmailField ) ){
                //if(self.view.frame.origin.y == 0){
                self.view.frame.origin.y -= (2.6*getKeyboardHeight(notification)/3)
                currentlyEditing = true
                // }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification){
        //print(fieldTag)
        print("WillHide the actual value will hide: \(fieldTag) ")
        print("WillHide keyboard up?: \(self.currentlyEditing) ")
     
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
