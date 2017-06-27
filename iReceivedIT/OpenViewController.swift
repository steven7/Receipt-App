//
//  OpenViewController.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/1/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit



class OpenViewController: UIViewController{

    @IBOutlet weak var loginButton:UIButton!
    @IBOutlet weak var newReceiptButton:UIButton!
    @IBOutlet weak var savedReceiptButton:UIButton!
    @IBOutlet weak var prefillButton:UIButton!
    @IBOutlet weak var aboutButton:UIButton!
    @IBOutlet var loginToLogoConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        diffIfOnIphone5()
        
        buttonBorders()
        
    }
    
    
    @IBAction func loginButtonPressed(sender: AnyObject) {
        print("pressed")
    }
    
    @IBAction func newReceiptButtonPressed(sender: AnyObject) {
        print("pressed")
    }
    
    @IBAction func savedReceiptButtonPressed(sender: AnyObject) {
        print("pressed")
    }
    
    @IBAction func prefillButtonPressed(sender: AnyObject) {
        print("pressed")
    }
    
    @IBAction func aboutButtonPressed(sender: AnyObject) {
        print("pressed")
    }
    
    func buttonBorders(){
        
        loginButton.layer.cornerRadius = 5
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = self.view.tintColor.CGColor
        
        newReceiptButton.layer.cornerRadius = 5
        newReceiptButton.layer.borderWidth = 1
        newReceiptButton.layer.borderColor = self.view.tintColor.CGColor
        
        savedReceiptButton.layer.cornerRadius = 5
        savedReceiptButton.layer.borderWidth = 1
        savedReceiptButton.layer.borderColor = self.view.tintColor.CGColor
        
        prefillButton.layer.cornerRadius = 5
        prefillButton.layer.borderWidth = 1
        prefillButton.layer.borderColor = self.view.tintColor.CGColor
        
        aboutButton.layer.cornerRadius = 5
        aboutButton.layer.borderWidth = 1
        aboutButton.layer.borderColor = self.view.tintColor.CGColor
    }
    
    func diffIfOnIphone5(){
        if UIDevice().userInterfaceIdiom == .Phone {
            if (UIScreen.mainScreen().nativeBounds.height == 1136 ){
                print("this is an iphone 5!!!!!")
                loginToLogoConstraint.constant = 0
                self.view.updateConstraints()
            }
        }
    }
}
