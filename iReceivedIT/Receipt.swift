//
//  ReceiptItem.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/4/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import Foundation

class Receipt: NSObject  {
    
    var goodsDescription:String
    var locationReceived:String
    var pONumber:String
    var weight:String
    var bOLNuber:String
    var rebate:String
    var cost:String
    var dateReceived:String
    var paymentDueDate:String
    var other:String
    var dateCreated:String
    
    var plusOne:String
    var plusTwo:String
    
    
    var goodsDescription_ImagePath:String!
    var locationReceived_ImagePath:String!
    var pONumber_ImagePath:String!
    var weight_ImagePath:String!
    var bOLNuber_ImagePath:String!
    var rebate_ImagePath:String!
    var cost_ImagePath:String!
    var dateReceived_ImagePath:String!
    var paymentDueDate_ImagePath:String!
    var other_ImagePath:String!
    
    var plusOne_ImagePath:String!
    var plusTwo_ImagePath:String!
    
    /*
    var userName:String
    
    var businessName:String
    var facilityAddress:String
    
    var tinyImagePath: String
    
    var userPhoneNumber:String
    var userEmailAddress:String
    var userSupervisorsName:String
    var userSupervisorsEmail:String
    
    let userKey: String
    */
    /*
     var name: String
     var valueInDollars: Int
     var serialNumber: String?
     let dateCreated: NSDate
     let itemKey: String
     */
    
    init(goodsDescription:String, locationReceived:String, pONumber:String, weight:String, bOLNuber:String, rebate:String, cost:String, dateReceived:String, paymentDueDate:String, other:String, dateCreated:String, plusOne:String, plusTwo:String) {
        
        
        if(goodsDescription  != ""){
            self.goodsDescription = goodsDescription
        }else{
            self.goodsDescription = "no entry"
        }
        
        if(locationReceived != ""){
            self.locationReceived = locationReceived
        }else{
            self.locationReceived = "no entry"
        }
        
        if(pONumber != ""){
            self.pONumber = pONumber
        }else{
            self.pONumber = "no entry"
        }
        
        if(weight != ""){
            self.weight = weight
        }else{
            self.weight = "no entry"
        }
        
        if(bOLNuber != ""){
            self.bOLNuber = bOLNuber
        }else{
            self.bOLNuber = "no entry"
        }
        
        if(rebate != ""){
            self.rebate = rebate
        }else{
            self.rebate = "no entry"
        }
        
        if(cost != ""){
            self.cost = cost
        }else{
            self.cost = "no entry"
        }
        
        if(dateReceived != ""){
            self.dateReceived = dateReceived
        }else{
            self.dateReceived = "no entry"
        }
        
        if(paymentDueDate != ""){
            self.paymentDueDate = paymentDueDate
        }else{
            self.paymentDueDate = "no entry"
        }
        
        if(other != ""){
            self.other = other
        }else{
            self.other = "no entry"
        }
        
        if(dateCreated != ""){
            self.dateCreated = dateCreated
        }else{
            self.dateCreated = "no entry"
        }
        
        if(plusOne != ""){
            self.plusOne = plusOne
        }else{
            self.plusOne = "no entry"
        }
        
        if(plusTwo != ""){
            self.plusTwo = plusTwo
        }else{
            self.plusTwo = "no entry"
        }
        
    }
    
    /*
    init(goodsDescription:String, locationReceived:String, pONumber:String, weight:String, bOLNuber:String, rebate:String, cost:String, dateReceived:String, paymentDueDate:String, other:String, dateCreated:String, goodsDescription_ImagePath:String, locationReceived_ImagePath:String, pONumber_ImagePath:String, weight_ImagePath:String, bOLNuber_ImagePath:String, rebate_ImagePath:String, cost_ImagePath:String, dateReceived_ImagePath:String, paymentDueDate_ImagePath:String, other_ImagePath:String) {
        
        
        if(goodsDescription  != ""){
            self.goodsDescription = goodsDescription
        }else{
            self.goodsDescription = "no entry"
        }
        
        if(locationReceived != ""){
            self.locationReceived = locationReceived
        }else{
            self.locationReceived = "no entry"
        }
        
        if(pONumber != ""){
            self.pONumber = pONumber
        }else{
            self.pONumber = "no entry"
        }
        
        if(weight != ""){
            self.weight = weight
        }else{
            self.weight = "no entry"
        }
        
        if(bOLNuber != ""){
            self.bOLNuber = bOLNuber
        }else{
            self.bOLNuber = "no entry"
        }
        
        if(rebate != ""){
            self.rebate = rebate
        }else{
            self.rebate = "no entry"
        }
        
        if(cost != ""){
            self.cost = cost
        }else{
            self.cost = "no entry"
        }
        
        if(dateReceived != ""){
            self.dateReceived = dateReceived
        }else{
            self.dateReceived = "no entry"
        }
        
        if(paymentDueDate != ""){
            self.paymentDueDate = paymentDueDate
        }else{
            self.paymentDueDate = "no entry"
        }
        
        if(other != ""){
            self.other = other
        }else{
            self.other = "no entry"
        }
        
        if(dateCreated != ""){
            self.dateCreated = dateCreated
        }else{
            self.dateCreated = "no entry"
        }
        
        if(goodsDescription_ImagePath  != ""){
            self.goodsDescription_ImagePath = goodsDescription_ImagePath
        }else{
            self.goodsDescription_ImagePath = "no entry"
        }
        
        if(locationReceived_ImagePath != ""){
            self.locationReceived_ImagePath = locationReceived_ImagePath
        }else{
            self.locationReceived_ImagePath = "no entry"
        }
        
        if(pONumber_ImagePath != ""){
            self.pONumber_ImagePath = pONumber_ImagePath
        }else{
            self.pONumber_ImagePath = "no entry"
        }
        
        if(weight_ImagePath != ""){
            self.weight_ImagePath = weight_ImagePath
        }else{
            self.weight_ImagePath = "no entry"
        }
        
        if(bOLNuber_ImagePath != ""){
            self.bOLNuber_ImagePath = bOLNuber_ImagePath
        }else{
            self.bOLNuber_ImagePath = "no entry"
        }
        
        if(rebate_ImagePath != ""){
            self.rebate_ImagePath = rebate_ImagePath
        }else{
            self.rebate_ImagePath = "no entry"
        }
        
        if(cost_ImagePath != ""){
            self.cost_ImagePath = cost_ImagePath
        }else{
            self.cost_ImagePath = "no entry"
        }
        
        if(dateReceived_ImagePath != ""){
            self.dateReceived_ImagePath = dateReceived_ImagePath
        }else{
            self.dateReceived_ImagePath = "no entry"
        }
        
        if(paymentDueDate_ImagePath != ""){
            self.paymentDueDate_ImagePath = paymentDueDate_ImagePath
        }else{
            self.paymentDueDate_ImagePath = "no entry"
        }
        
        if(other_ImagePath != ""){
            self.other_ImagePath = other_ImagePath
        }else{
            self.other_ImagePath = "no entry"
        }
        
    }
    */
    
    init(goodsDescription:String, locationReceived:String, pONumber:String, weight:String, bOLNuber:String, rebate:String, cost:String, dateReceived:String, paymentDueDate:String, other:String, dateCreated:String, plusOne:String, plusTwo:String, goodsDescription_ImagePath:String, locationReceived_ImagePath:String, pONumber_ImagePath:String, weight_ImagePath:String, bOLNuber_ImagePath:String, rebate_ImagePath:String, cost_ImagePath:String, dateReceived_ImagePath:String, paymentDueDate_ImagePath:String, other_ImagePath:String, plusOne_ImagePath:String, plusTwo_ImagePath:String) {
        
        if(goodsDescription  != ""){
            self.goodsDescription = goodsDescription
        }else{
            self.goodsDescription = "no entry"
        }
        
        if(locationReceived != ""){
            self.locationReceived = locationReceived
        }else{
            self.locationReceived = "no entry"
        }
        
        if(pONumber != ""){
            self.pONumber = pONumber
        }else{
            self.pONumber = "no entry"
        }
        
        if(weight != ""){
            self.weight = weight
        }else{
            self.weight = "no entry"
        }
        
        if(bOLNuber != ""){
            self.bOLNuber = bOLNuber
        }else{
            self.bOLNuber = "no entry"
        }
        
        if(rebate != ""){
            self.rebate = rebate
        }else{
            self.rebate = "no entry"
        }
        
        if(cost != ""){
            self.cost = cost
        }else{
            self.cost = "no entry"
        }
        
        if(dateReceived != ""){
            self.dateReceived = dateReceived
        }else{
            self.dateReceived = "no entry"
        }
        
        if(paymentDueDate != ""){
            self.paymentDueDate = paymentDueDate
        }else{
            self.paymentDueDate = "no entry"
        }
        
        if(other != ""){
            self.other = other
        }else{
            self.other = "no entry"
        }
        
        if(dateCreated != ""){
            self.dateCreated = dateCreated
        }else{
            self.dateCreated = "no entry"
        }
        
        if(plusOne != ""){
            self.plusOne = plusOne
        }else{
            self.plusOne = "no entry"
        }
        
        if(plusTwo != ""){
            self.plusTwo = plusTwo
        }else{
            self.plusTwo = "no entry"
        }
        
        if(goodsDescription_ImagePath  != ""){
            self.goodsDescription_ImagePath = goodsDescription_ImagePath
        }else{
            self.goodsDescription_ImagePath = "no entry"
        }
        
        if(locationReceived_ImagePath != ""){
            self.locationReceived_ImagePath = locationReceived_ImagePath
        }else{
            self.locationReceived_ImagePath = "no entry"
        }
        
        if(pONumber_ImagePath != ""){
            self.pONumber_ImagePath = pONumber_ImagePath
        }else{
            self.pONumber_ImagePath = "no entry"
        }
        
        if(weight_ImagePath != ""){
            self.weight_ImagePath = weight_ImagePath
        }else{
            self.weight_ImagePath = "no entry"
        }
        
        if(bOLNuber_ImagePath != ""){
            self.bOLNuber_ImagePath = bOLNuber_ImagePath
        }else{
            self.bOLNuber_ImagePath = "no entry"
        }
        
        if(rebate_ImagePath != ""){
            self.rebate_ImagePath = rebate_ImagePath
        }else{
            self.rebate_ImagePath = "no entry"
        }
        
        if(cost_ImagePath != ""){
            self.cost_ImagePath = cost_ImagePath
        }else{
            self.cost_ImagePath = "no entry"
        }
        
        if(dateReceived_ImagePath != ""){
            self.dateReceived_ImagePath = dateReceived_ImagePath
        }else{
            self.dateReceived_ImagePath = "no entry"
        }
        
        if(paymentDueDate_ImagePath != ""){
            self.paymentDueDate_ImagePath = paymentDueDate_ImagePath
        }else{
            self.paymentDueDate_ImagePath = "no entry"
        }
        
        if(other_ImagePath != ""){
            self.other_ImagePath = other_ImagePath
        }else{
            self.other_ImagePath = "no entry"
        }
        
        if(plusOne_ImagePath != ""){
            self.plusOne_ImagePath = plusOne_ImagePath
        }else{
            self.plusOne_ImagePath = "no entry"
        }
        
        if(plusTwo_ImagePath != ""){
            self.plusTwo_ImagePath = plusTwo_ImagePath
        }else{
            self.plusTwo_ImagePath = "no entry"
        }
    }
}

