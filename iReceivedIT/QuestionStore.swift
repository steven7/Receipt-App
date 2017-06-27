//
//  QuestionStore.swift
//  iReceivedIT
//
//  Created by Steven Kanceruk on 10/28/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit
import Foundation

class QuestionStore{
    
    var businessName:String!
    var facilityAddress:String!
    var userNameField:String!
    var pictureOfUserField:String!
    var userPhoneNumberField:String!
    var userEmailAddressField:String!
    var userSupervisorsNameField:String!
    var userSupervisorsEmailField:String!
    
    var theQuestions = [[String]]()
    var inputDictionary = [Int: String]()
    var imageDictionary = [Int: UIImage]()
    
    static let sharedInstance = QuestionStore()
    
    private init() {
        
        businessName = nil
        facilityAddress = nil
        userNameField = nil
        pictureOfUserField = nil
        userPhoneNumberField = nil
        userEmailAddressField = nil
        userSupervisorsNameField = nil
        userSupervisorsEmailField = nil
        
        theQuestions = [
            ["Receiving Location","Supplier","PO Number","BOL Number","Trailer/Truck Number","Material Description","Weight","UOM","Cost","Rebate","Payment Amount","Payment Due Date"],
            
            ["Rebate","Cost","Date Received","Payment Due Date","Other"]//,
            /*
            ["question 1","question 2","question 3","question 4","question 5"],
            
            ["question 1","question 2","question 3","question 4","question 5"],
            ["sfsquestion 1","quesfsfstion 2","questiosfsfn 3","quessfsftion 4","questisfson 5"],
            ["question 1","question 2","question 3","question 4","question 5"]
            */
        ]
        
    }
    
    
    /*
    let theQuestions = [
                        ["Goods Description","Location Received","PO#","Weight","BOL#"],
                        
                        ["Rebate","Cost","Date Received","Payment Due Date","Other"],
                        
                        ["question 1","question 2","question 3","question 4","question 5"],
                        
                        ["question 1","question 2","question 3","question 4","question 5"],
                        ["sfsquestion 1","quesfsfstion 2","questiosfsfn 3","quessfsftion 4","questisfson 5"],
                        ["question 1","question 2","question 3","question 4","question 5"]
    ]
     */
    func getQuestions() -> [Array<String>]{
        return theQuestions
    }
}
 
