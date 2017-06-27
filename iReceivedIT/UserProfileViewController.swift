//
//  UserProfileViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/1/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//


import UIKit



class UserProfileViewController: UIViewController{
    
    @IBOutlet var newButton: UIButton!
    
    @IBOutlet var loadButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonBorders()
    }
    
    func buttonBorders(){
        
        newButton.layer.cornerRadius = 5
        newButton.layer.borderWidth = 1
        newButton.layer.borderColor = self.view.tintColor.CGColor
        
        loadButton.layer.cornerRadius = 5
        loadButton.layer.borderWidth = 1
        loadButton.layer.borderColor = self.view.tintColor.CGColor
    }
}
