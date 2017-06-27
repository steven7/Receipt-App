//
//  OneCell.swift
//  iReceivedIT
//
//  Created by Steven Kanceruk on 10/28/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit

protocol ChangePictureProtocol : NSObjectProtocol {
    func loadNewScreen(controller: UIViewController) -> Void;
}

class OneCell: UITableViewCell, UIImagePickerControllerDelegate {
    
    @IBOutlet var questionLabel:  UILabel!
    @IBOutlet var userInputField: UITextField!
    @IBOutlet var cameraImageButton: UIButton!
    
    var pageIndex:Int!
    var pageRow:Int!
    var key:Int!
    let data = QuestionStore.sharedInstance
    
    weak var delegate: ChangePictureProtocol?
    
    @IBAction func changePicture(sender: AnyObject)->Void
    {
        
    }
    
    @IBAction func camerButtonPressed(sender: AnyObject) {
        
            
        /*
        var pickerVC = UIImagePickerController();
        if((delegate?.respondsToSelector("loadNewScreen:")) != nil)
        {
            delegate?.loadNewScreen(pickerVC);
        }
        */
        /*
        print("Pressed yo")
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
        */
    }
    
    func updateFieldFromDict(){
        key = (pageIndex * 100) + pageRow
        if data.inputDictionary[key] != nil{
            //segementedControl.setEnabled(true, forSegmentAtIndex: key)
            //okSwitch.on = true
            if data.inputDictionary[key] != "no answer"{
                //detailLabel.text = data.inputDictionary[key]
                print("was already on with value \(data.inputDictionary[key])")
            }
        }else{
            //detailLabel.text = ""
            //data.inputDictionary.updateValue("no answer", forKey:key)
            print(" not already on the field was")
        }
    }
 
    /*
     func updateLabels(){
     let bodyFont = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
     nameLabel.font = bodyFont
     valueLabel.font = bodyFont
     
     let caption1Font = UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1)
     serialNaumberLabel.font = caption1Font
     }
     */
    
}
