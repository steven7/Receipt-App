//
//  questionCell.swift
//  iReceivedIT
//
//  Created by Steven Kanceruk on 10/28/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {
   
    @IBOutlet var questionLabel:  UILabel!
    @IBOutlet var detailLabel: UILabel!
    @IBOutlet var theImage: UIImageView!
    @IBOutlet var justForShowField: UITextField!
    
    var pageIndex:Int!
    var pageRow:Int!
    var key:Int!
    let data = QuestionStore.sharedInstance
    
    func viewDidLoad(){
        justForShowField.userInteractionEnabled = false
        //justForShowField.enabled = false
        
    }
    
    func updateFieldFromDict(){
        //key = (pageIndex * 100) + pageRow
        if data.inputDictionary[key] != nil{
            //segementedControl.setEnabled(true, forSegmentAtIndex: key)
            //okSwitch.on = true
            if data.inputDictionary[key] != "no answer"{
                detailLabel.text = data.inputDictionary[key]
                print("was already on with value \(data.inputDictionary[key])")
            }
        }else{
            detailLabel.text = ""
            //data.inputDictionary.updateValue("no answer", forKey:key)
            print("was not already on the field was")
        }
    }
    
    func updateImageFromDict(){
        //key = (pageIndex * 100) + pageRow
        if data.imageDictionary[key] != nil{
            //segementedControl.setEnabled(true, forSegmentAtIndex: key)
            //okSwitch.on = true
            print("the cell has key and a saved image jjj \(key)")
            if data.imageDictionary[key] != nil{
                self.theImage.image = data.imageDictionary[key]
                print("\(key) was already on with value \(data.imageDictionary[key])")
            }
        }else{
            self.theImage.image = UIImage(named: "Camera")
            print("the cell has key \(key)")
            //data.imageDictionary.updateValue(nil, forKey:key)
            //print("was not already on the field was")
        }
    }
   
}
