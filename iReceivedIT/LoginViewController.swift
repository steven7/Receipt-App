//
//  LoginViewController.swift
//  iReceivedIT
//
//  Created by Steven Kanceruk on 10/28/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit
//import QuartzCore

class LoginViewController: UIViewController, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var businessNameField:UITextField!
    @IBOutlet weak var facilityAddressField:UITextField!
    
    @IBOutlet weak var pictureOfUserButton:UIButton!
    @IBOutlet weak var tinyImage: UIImageView!
    
    @IBOutlet weak var userPhoneNumberField:UITextField!
    @IBOutlet weak var userEmailAddressField:UITextField!
    @IBOutlet weak var userSupervisorsNameField:UITextField!
    @IBOutlet weak var userSupervisorsEmailField:UITextField!
    
    @IBOutlet var loadProfileButton: UIButton!
    @IBOutlet weak var submitButton:UIButton!
    
    @IBOutlet var leftBarButton: UIBarButtonItem!
    
    @IBAction func leftBarButtonPressed(sender: AnyObject) {
    }
    
    @IBOutlet var rightBarButton: UIBarButtonItem!
    
    
    @IBAction func rightBarButtonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("toDataInput", sender: self)
    }
    
    var fieldTag = 0
    var currentField:UITextField!
    let techInfo = NSUserDefaults.standardUserDefaults()
    var keyboardCount = 0
    var currentlyEditing = false
    
    let data = QuestionStore.sharedInstance
    var database = DBManager.shared
    let imageStore = ImageStore.sharedInstance
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        
        self.performSegueWithIdentifier("toDataInput", sender: self)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadProfileButton.layer.cornerRadius = 5
        loadProfileButton.layer.borderWidth = 1
        loadProfileButton.layer.borderColor = self.view.tintColor.CGColor
        
        submitButton.layer.cornerRadius = 5
        submitButton.layer.borderWidth = 1
        submitButton.layer.borderColor = self.view.tintColor.CGColor
        
        //let greenColor = UIColor(hexString: "64FF7A")
        //submitButton.layer.borderColor = UIColor.blueColor().CGColor
        //submitButton.layer.borderColor = UIColor(red: 100, green: 255, blue: 122, alpha: 1.0).CGColor
        
        businessNameField.delegate = self
        facilityAddressField.delegate = self
        //userNameField.delegate = self
        //pictureOfUserField.delegate = self
        userPhoneNumberField.delegate = self
        userEmailAddressField.delegate = self
        userSupervisorsNameField.delegate = self
        userSupervisorsEmailField.delegate = self
        
        businessNameField.backgroundColor = UIColor.groupTableViewBackgroundColor()
        facilityAddressField.backgroundColor = UIColor.groupTableViewBackgroundColor()
        //userNameField.delegate = self
        //pictureOfUserField.delegate = self
        userPhoneNumberField.backgroundColor = UIColor.groupTableViewBackgroundColor()
        userEmailAddressField.backgroundColor = UIColor.groupTableViewBackgroundColor()
        userSupervisorsNameField.backgroundColor = UIColor.groupTableViewBackgroundColor()
        userSupervisorsEmailField.backgroundColor = UIColor.groupTableViewBackgroundColor()
        /*
        if let businessName = NSUserDefaults.standardUserDefaults().valueForKey("businessName"){
            businessNameField.text = businessName as? String
        }
        if let facilityAddress = NSUserDefaults.standardUserDefaults().valueForKey("facilityAddress"){
            facilityAddressField.text = facilityAddress as? String
        }
        if let userPhoneNumber = NSUserDefaults.standardUserDefaults().valueForKey("userPhoneNumber"){
            userPhoneNumberField.text = userPhoneNumber as? String
        }
        if let userEmailAddress = NSUserDefaults.standardUserDefaults().valueForKey("userEmailAddress"){
            userEmailAddressField.text = userEmailAddress as? String
        }
        if let userSupervisorsName = NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsName"){
            userSupervisorsNameField.text = userSupervisorsName as? String
        }
        if let userSupervisorsEmail = NSUserDefaults.standardUserDefaults().valueForKey("userSupervisorsEmail"){
            userSupervisorsEmailField.text = userSupervisorsEmail as? String
        }
        */
    
        diffIfOnIphone5()
    }
    
    func diffIfOnIphone5(){
        if UIDevice().userInterfaceIdiom == .Phone {
            if (UIScreen.mainScreen().nativeBounds.height == 1136 ){
                
                print("iPhone 5 or 5S or 5C")
                
                submitButton.enabled = false
                submitButton.hidden = true
                loadProfileButton.enabled = false
                loadProfileButton.hidden = true
                
                leftBarButton.enabled = true
                rightBarButton.enabled = true
                //rightBarButton.tintColor = UIColor.clearColor()
                
            }
            else{
                submitButton.enabled = true
                submitButton.hidden = false
                loadProfileButton.enabled = true
                loadProfileButton.hidden = false
                rightBarButton.enabled = false
                leftBarButton.tintColor = UIColor.clearColor()
                rightBarButton.enabled = false
                rightBarButton.tintColor = UIColor.clearColor()
            }
        }else{
            print("is NOT iPhone 5 or 5S or 5C")
            submitButton.enabled = true
            submitButton.hidden = false
            loadProfileButton.enabled = true
            loadProfileButton.hidden = false
            rightBarButton.enabled = false
            leftBarButton.tintColor = UIColor.clearColor()
            rightBarButton.enabled = false
            rightBarButton.tintColor = UIColor.clearColor()
        }
    }
    
    func loadCurrentUser(){
        if(database.currentUser != nil){
            
            let businessName = database.currentUser.businessName
            businessNameField.text = businessName
        
            let facilityAddress = database.currentUser.facilityAddress
            facilityAddressField.text = facilityAddress
         
            let userPictureKey = database.currentUser.tinyImagePath
            if(userPictureKey != "no picture"){
                self.tinyImage.image = imageStore.imageForKey(userPictureKey)
            }
            
            let userPhoneNumber = database.currentUser.userPhoneNumber
            userPhoneNumberField.text = userPhoneNumber
         
            let userEmailAddress = database.currentUser.userEmailAddress
            userEmailAddressField.text = userEmailAddress
            let userSupervisorsName = database.currentUser.userSupervisorsName
            userSupervisorsNameField.text = userSupervisorsName
         
            let userSupervisorsEmail = database.currentUser.userSupervisorsEmail
            userSupervisorsEmailField.text = userSupervisorsEmail
            
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        loadCurrentUser()
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
        tinyImage.image = image
        
        //take picker off screen
        dismissViewControllerAnimated(true, completion: nil)
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
        //print("the value: self.currentTextField!.tag")
        //fieldTag = self.currentTextField!.tag
        //print(self.currentTextField!.tag)
        //print(fieldTag)
        print("WillShow the actual value will show: \(fieldTag) ")
        print("WillShow keyboard up?: \(self.currentlyEditing) ")
        if(currentlyEditing == false ){
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
