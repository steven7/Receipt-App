//
//  DBManager.swift
//  iRECEIVEDit
//
//  Created by Steven Kanceruk on 11/4/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit

class DBManager: NSObject {

    let field_MovieID = "movieID"
    let field_MovieTitle = "title"
    let field_MovieCategory = "category"
    let field_MovieYear = "year"
    let field_MovieURL = "movieURL"
    let field_MovieCoverURL = "coverURL"
    let field_MovieWatched = "watched"
    let field_MovieLikes = "likes"
    
    
    let field_Users_BussinessName = "bussinessName"
    let field_Users_FacilityAddress = "facilityAddress"
    let field_Users_PictureOfUser = "pictureOfUser"
    let field_Users_TinyImagePath = "tinyImagePath"
    let field_Users_UserPhoneNumber = "userPhoneNumber"
    let field_Users_UserEmailAddress = "userEmailAddress"
    let field_Users_UserSupervisorsName = "userSupervisorsName"
    let field_Users_UserSupervisorsEmail = "userSupervisorsEmail"
    let field_Users_UserKey = "userKey"
    
    let field_Receipts_GoodsDescription = "goodsDescription"
    let field_Receipts_LocationReceived = "locationReceived"
    let field_Receipts_PONumber = "pONumber"
    let field_Receipts_Weight = "weight"
    let field_Receipts_BOLNuber = "bOLNuber"
    let field_Receipts_Rebate = "rebate"
    let field_Receipts_Cost = "cost"
    let field_Receipts_DateReceived = "dateReceived"
    let field_Receipts_PaymentDueDate = "paymentDueDate"
    let field_Receipts_Other = "other"
    let field_Receipts_DateCreated = "dateCreated"
    let field_Receipts_Plus_One = "plusOne"
    let field_Receipts_Plus_Two = "plusTwo"
    let field_Receipts_Plus_Three = "plusThree"
    
    let field_Receipts_GoodsDescription_ImagePath = "goodsDescription_ImagePath"
    let field_Receipts_LocationReceived_ImagePath = "locationReceived_ImagePath"
    let field_Receipts_PONumber_ImagePath = "pONumber_ImagePath"
    let field_Receipts_Weight_ImagePath = "weight_ImagePath"
    let field_Receipts_BOLNuber_ImagePath = "bOLNuber_ImagePath"
    let field_Receipts_Rebate_ImagePath = "rebate_ImagePath"
    let field_Receipts_Cost_ImagePath = "cost_ImagePath"
    let field_Receipts_DateReceived_ImagePath = "dateReceived_ImagePath"
    let field_Receipts_PaymentDueDate_ImagePath = "paymentDueDate_ImagePath"
    let field_Receipts_Other_ImagePath = "other_ImagePath"
    let field_Receipts_Plus_One_ImagePath = "plusOne_ImagePath"
    let field_Receipts_Plus_Two_ImagePath = "plusTwo_ImagePath"
    let field_Receipts_Plus_Three_ImagePath = "plusThree_ImagePath"
    
    let field_Prefill_EntryNumber = "entryNumber_Prefill"
    let field_Prefill_GoodsDescription = "goodsDescription_Prefill"
    let field_Prefill_LocationReceived = "locationReceived_Prefill"
    let field_Prefill_PONumber = "pONumber_Prefill"
    let field_Prefill_Weight = "weight_Prefill"
    let field_Prefill_BOLNuber = "bOLNumber_Prefill"
    let field_Prefill_Rebate = "rebate_Prefill"
    let field_Prefill_Cost = "cost_Prefill"
    let field_Prefill_DateReceived = "dateReceived_Prefill"
    let field_Prefill_PaymentDueDate = "paymentDueDate_Prefill"
    let field_Prefill_Other = "other_Prefill"
    let field_Prefill_Plus_One = "plusOne_Prefill"
    let field_Prefill_Plus_Two = "plusTwo_Prefill"
    let field_Prefill_Plus_Three = "plusThree_Prefill"
    
    
    var carryover_Prefill:String!
    
    var carryover_Prefill_EntryNumber:String!
    var carryover_Prefill_GoodsDescription:String!
    var carryover_Prefill_LocationReceived:String!
    var carryover_Prefill_PONumber:String!
    var carryover_Prefill_Weight:String!
    var carryover_Prefill_BOLNuber:String!
    var carryover_Prefill_Rebate:String!
    var carryover_Prefill_Cost:String!
    var carryover_Prefill_DateReceived:String!
    var carryover_Prefill_PaymentDueDate:String!
    var carryover_Prefill_Other:String!
    
    static let shared: DBManager = DBManager()
    
    let data = QuestionStore.sharedInstance
    
    let imageStore = ImageStore.sharedInstance
    
    let databaseFileName = "database.sqlite"
    
    var pathToDatabase: String!
    
    var database: FMDatabase!
    
    var currentUser:User!
    
    var currentRecipt:Receipt!
    
    var heldOverPrefillString:String!
    
    var currentUserInfo = [String]()
    
    override init() {
        super.init()
        
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as NSString) as String
        
        print("database is at \(documentsDirectory)")
        
        let url = NSURL(fileURLWithPath: "\(documentsDirectory)/\(databaseFileName)")
        pathToDatabase = url.path//documentsDirectory.stringByAppendingString("/\(databaseFileName)")
        
        print("database is at \(pathToDatabase)")
    }
    
    func createDatabase() -> Bool {
        var created = false
        
        print("lets create a databse")
        
        //if !NSFileManager.defaultManager().fileExistsAtPath(pathToDatabase){
        //if !FileManager.default.fileExists(atPath: pathToDatabase) {
        do{
        //default.fileExists(atPath: pathToDatabase) {
            try database = FMDatabase(path: pathToDatabase!)
            print(database)
            if database != nil {
                // Open the database.
                if database.open() {
                    
                    print("database open!!")
                    
                    let createUsersTableQuery = "create table users (\(field_Users_BussinessName) text not null, \(field_Users_FacilityAddress) text not null, \(field_Users_TinyImagePath) text not null, \(field_Users_UserPhoneNumber) text not null, \(field_Users_UserEmailAddress) text not null, \(field_Users_UserSupervisorsName) text not null, \(field_Users_UserSupervisorsEmail) text not null, \(field_Users_UserKey) text not null)"
                    
                    let createReceiptTableQuery = "create table receipts (\(field_Receipts_GoodsDescription) text not null, \(field_Receipts_LocationReceived) text not null, \(field_Receipts_PONumber) text not null, \(field_Receipts_Weight) text not null, \(field_Receipts_BOLNuber) text not null, \(field_Receipts_Rebate) text not null, \(field_Receipts_Cost) text not null, \(field_Receipts_DateReceived) text not null, \(field_Receipts_PaymentDueDate) text not null, \(field_Receipts_Other) text not null, \(field_Receipts_DateCreated) text not null, \(field_Receipts_Plus_One) text not null, \(field_Receipts_Plus_Two) text not null, \(field_Receipts_Plus_Three) text not null,\(field_Receipts_GoodsDescription_ImagePath) text not null, \(field_Receipts_LocationReceived_ImagePath) text not null, \(field_Receipts_PONumber_ImagePath) text not null, \(field_Receipts_Weight_ImagePath) text not null, \(field_Receipts_BOLNuber_ImagePath) text not null, \(field_Receipts_Rebate_ImagePath) text not null, \(field_Receipts_Cost_ImagePath) text not null, \(field_Receipts_DateReceived_ImagePath) text not null, \(field_Receipts_PaymentDueDate_ImagePath) text not null, \(field_Receipts_Other_ImagePath) text not null, \(field_Receipts_Plus_One_ImagePath) text not null, \(field_Receipts_Plus_Two_ImagePath) text not null, \(field_Receipts_Plus_Three_ImagePath) text not null)"
                    
                    let createPrefillTableQuery = "create table prefill (\(field_Prefill_EntryNumber) text, \(field_Prefill_GoodsDescription) text, \(field_Prefill_LocationReceived) text, \(field_Prefill_PONumber) text, \(field_Prefill_Weight) text, \(field_Prefill_BOLNuber) text, \(field_Prefill_Rebate) text, \(field_Prefill_Cost) text, \(field_Prefill_DateReceived) text, \(field_Prefill_PaymentDueDate) text, \(field_Prefill_Other) text, \(field_Prefill_Plus_One) text, \(field_Prefill_Plus_Two) text)"
                  
                    
                    
                    do {
                        
                        try database.executeUpdate(createPrefillTableQuery, values: nil)
                        try database.executeUpdate(createUsersTableQuery, values: nil)
                        try database.executeUpdate(createReceiptTableQuery, values: nil)
                        
                        let rowNumbers = ["0","1","2","3","4","5","6"]//,"7","8"]
                        firstInsertPrefillData(rowNumbers, prefillColumn: field_Prefill_EntryNumber)
                        
                        created = true
                        print("all the tables created!!?!!")
                        print("all the data added!!?!!")
                    }
                    catch {
                        print("Could not create table.")
                        print(error)
                    }
                    
                    database.close()
                    
                }
                else {
                    print("Could not open the database.")
                }
            }
        }
        catch{
            print("errorCould not open the database.")
            print(error)
        }
        
        return created
    }

    func openDatabase() -> Bool {
        if database == nil {
            print("data not base open!")
            print(pathToDatabase)
            if !NSFileManager.defaultManager().fileExistsAtPath(pathToDatabase){
            //if FileManager.default.fileExists(atPath: pathToDatabase) {
                print("path exits")
                database = FMDatabase(path: pathToDatabase)
                print("database created!")
            }else{
                print("nope")
            }
        }
        
        if database != nil {
            print("data base open!")
            if database.open() {
                return true
            }
        }
        
        return false
    }
    
    ////////////
    ///
    ///  insert
    ///
    ////////////
    
    func insertUserData(userInfo: [String]) {
        // Open the database.
        if openDatabase() {
            do{
                
                let businessName = userInfo[0]
                let facilityAddress = userInfo[1]
                
                let tinyImagePath = userInfo[2]
                
                let userPhoneNumber = userInfo[3]
                let userEmailAddress = userInfo[4]
                let userSupervisorsName = userInfo[5]
                let userSupervisorsEmail = userInfo[6]
                
                let userKey = userInfo[7]
                
                print("\(userInfo)")
                
                let query = "insert into users (\(field_Users_BussinessName), \(field_Users_FacilityAddress), \(field_Users_TinyImagePath), \(field_Users_UserPhoneNumber), \(field_Users_UserEmailAddress), \(field_Users_UserSupervisorsName), \(field_Users_UserSupervisorsEmail), \(field_Users_UserKey)) values ('\(businessName)', '\(facilityAddress)', '\(tinyImagePath)', '\(userPhoneNumber)', '\(userEmailAddress)', '\(userSupervisorsName)', '\(userSupervisorsEmail)', '\(userKey)');"
                
                print("inserted?")
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }else{
                    print("1 inserted to database!")
                }
                
                print("inserted?")
                
                self.currentUser = User(businessName: businessName,
                                             facilityAddress: facilityAddress,
                                             tinyImagePath: tinyImagePath,
                                             userPhoneNumber: userPhoneNumber,
                                             userEmailAddress: userEmailAddress,
                                             userSupervisorsName: userSupervisorsName,
                                             userSupervisorsEmail: userSupervisorsEmail //,
                    //userKey: Int(results.int(forColumn: field_Users_UserKey))
                )
                
            }catch {
                print("error?")
                print(error)
            }
         
            
            database.close()
        }
        
    }

    func insertReceiptData() {
        // Open the database.
        
        if openDatabase() {
            
            var goodsDescription:String!
            var locationReceived:String!
            var pONumber:String!
            var weight:String!
            var bOLNuber:String!
            var rebate:String!
            var cost:String!
            var dateReceived:String!
            var paymentDueDate :String!
            var other:String!
            
            var plusOne:String!
            var plusTwo:String!
            var plusThree :String!
            
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
            var plusThree_ImagePath :String!
            
            if(data.inputDictionary[0] != nil){
                goodsDescription = data.inputDictionary[0]
            }else{
                goodsDescription = "No Description"
            }
            
            if(data.inputDictionary[1] != nil){
                locationReceived = data.inputDictionary[1]
            }else{
                locationReceived = "No Description"
            }
            
            if(data.inputDictionary[2] != nil){
                pONumber = data.inputDictionary[2]
            }else{
                pONumber = "No Description"
            }
            
            if(data.inputDictionary[3] != nil){
                weight = data.inputDictionary[3]
            }else{
                weight = "No Description"
            }
            
            if(data.inputDictionary[4] != nil){
                bOLNuber = data.inputDictionary[4]
            }else{
                bOLNuber = "No Description"
            }
            if(data.inputDictionary[5] != nil){
                rebate = data.inputDictionary[5]
            }else{
                rebate = "No Description"
            }
            
            if(data.inputDictionary[6] != nil){
                cost = data.inputDictionary[6]
            }else{
                cost = "No Description"
            }
            
            if(data.inputDictionary[7] != nil){
                dateReceived = data.inputDictionary[7]
            }else{
                dateReceived = "No Description"
            }
            
            if(data.inputDictionary[8] != nil){
                paymentDueDate = data.inputDictionary[8]
            }else{
                paymentDueDate = "No Description"
            }
            
            if(data.inputDictionary[9] != nil){
                other = data.inputDictionary[9]
            }else{
                other = "No Description"
            }
            
            if(data.inputDictionary[10] != nil){
                plusOne = data.inputDictionary[10]
            }else{
                plusOne = "No Description"
            }
            
            if(data.inputDictionary[11] != nil){
                plusTwo = data.inputDictionary[11]
            }else{
                plusTwo = "No Description"
            }
            
            if(data.inputDictionary[12] != nil){
                plusThree = data.inputDictionary[12]
            }else{
                plusThree = "No Description"
            }
            
            let dateCreated = getCurrentDateTime()
            
            print("this is the stuff to be insterted")
            print("\(data.inputDictionary)")
            print("Created on \(dateCreated)")
            
            /////
            //////
            ////////
            
            ////
            ////
            /////
            
            
            if(data.imageDictionary[0] != nil){
                let image = data.imageDictionary[0]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                goodsDescription_ImagePath = imageKey
            }else{
                goodsDescription_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[1] != nil){
                let image = data.imageDictionary[1]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                locationReceived_ImagePath = imageKey
            }else{
                locationReceived_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[2] != nil){
                let image = data.imageDictionary[2]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                pONumber_ImagePath = imageKey
            }else{
                pONumber_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[3] != nil){
                let image = data.imageDictionary[3]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                weight_ImagePath = imageKey
            }else{
                weight_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[4] != nil){
                
                let image = data.imageDictionary[4]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                bOLNuber_ImagePath = imageKey
            }else{
                bOLNuber_ImagePath = "No Description"
            }
            
            
            if(data.imageDictionary[5] != nil){
                let image = data.imageDictionary[5]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                rebate_ImagePath = imageKey
            }else{
                rebate_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[6] != nil){
                let image = data.imageDictionary[6]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                cost_ImagePath = imageKey
            }else{
                cost_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[7] != nil){
                let image = data.imageDictionary[7]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                dateReceived_ImagePath = imageKey
            }else{
                dateReceived_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[8] != nil){
                let image = data.imageDictionary[8]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                paymentDueDate_ImagePath = imageKey
            }else{
                paymentDueDate_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[9] != nil){
                let image = data.imageDictionary[9]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                other_ImagePath = imageKey
            }else{
                other_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[10] != nil){
                let image = data.imageDictionary[10]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                plusOne_ImagePath = imageKey
            }else{
                plusOne_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[11] != nil){
                let image = data.imageDictionary[11]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                plusTwo_ImagePath = imageKey
            }else{
                plusTwo_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[12] != nil){
                let image = data.imageDictionary[12]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                plusThree_ImagePath = imageKey
            }else{
                plusThree_ImagePath = "No Description"
            }
            
            
            print("this is the stuff to be insterted")
            print("\(data.imageDictionary)")
            print("Created on \(dateCreated)")
            
            
            let query = "insert into receipts (\(field_Receipts_GoodsDescription), \(field_Receipts_LocationReceived), \(field_Receipts_PONumber), \(field_Receipts_Weight), \(field_Receipts_BOLNuber), \(field_Receipts_Rebate), \(field_Receipts_Cost), \(field_Receipts_DateReceived), \(field_Receipts_PaymentDueDate), \(field_Receipts_Other), \(field_Receipts_DateCreated), \(field_Receipts_Plus_One), \(field_Receipts_Plus_Two), \(field_Receipts_Plus_Three),\(field_Receipts_GoodsDescription_ImagePath), \(field_Receipts_LocationReceived_ImagePath), \(field_Receipts_PONumber_ImagePath), \(field_Receipts_Weight_ImagePath), \(field_Receipts_BOLNuber_ImagePath), \(field_Receipts_Rebate_ImagePath), \(field_Receipts_Cost_ImagePath), \(field_Receipts_DateReceived_ImagePath), \(field_Receipts_PaymentDueDate_ImagePath), \(field_Receipts_Other_ImagePath), \(field_Receipts_Plus_One_ImagePath), \(field_Receipts_Plus_Two_ImagePath), \(field_Receipts_Plus_Three_ImagePath)) values ('\(goodsDescription)', '\(locationReceived)', '\(pONumber)', '\(weight)', '\(bOLNuber)', '\(rebate)', '\(cost)', '\(dateReceived)', '\(paymentDueDate)', '\(other)', '\(dateCreated)', '\(plusOne)', '\(plusTwo)', '\(plusThree)', '\(goodsDescription_ImagePath)', '\(locationReceived_ImagePath)', '\(pONumber_ImagePath)', '\(weight_ImagePath)', '\(bOLNuber_ImagePath)', '\(rebate_ImagePath)', '\(cost_ImagePath)', '\(dateReceived_ImagePath)', '\(paymentDueDate_ImagePath)', '\(other_ImagePath)', '\(plusOne_ImagePath)', '\(plusTwo_ImagePath)' , '\(plusThree_ImagePath)' );"
        
            
            
            print("this is the one and only receipts query that matters -- ")
            
            print(query)
           
            print("inserted?")
            
            
            if !database.executeStatements(query) {
                print("Failed to insert initial receipt data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }else{
                print("receipts inserted to database!")
            }
            
            print("inserted?")
            
            database.close()
        }
    }
    
    func getCurrentDateTime() -> String{
        let formatter = NSDateFormatter()
        formatter.dateStyle = .LongStyle
        formatter.timeStyle = .LongStyle
        let datestring = formatter.stringFromDate(NSDate())
        return datestring
    }
    
    var fieldDict: [Int :String] = [
        0:"Goods Description",
        1:"Location Recieved",
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
    
    func insertReceiptPictureKeys() {
        // Open the database.
        
        if openDatabase() {
            
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
            
            if(data.imageDictionary[0] != nil){
                let image = data.imageDictionary[0]
                let imageKey = NSUUID().UUIDString
                goodsDescription_ImagePath = imageKey
                imageStore.setImage(image!, forKey: goodsDescription_ImagePath)
                print("!!!!!!!!image \(image) set for key \(goodsDescription_ImagePath)")
            }else{
                print("!!!!!!image \(goodsDescription_ImagePath) is now no description")
                goodsDescription_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[1] != nil){
                let image = data.imageDictionary[1]
                let imageKey = NSUUID().UUIDString
                locationReceived_ImagePath = imageKey
                imageStore.setImage(image!, forKey: locationReceived_ImagePath)
                print("!!!!!!!!image \(image) set for key \(locationReceived_ImagePath)")
            }else{
                print("!!!!!!image \(locationReceived_ImagePath) is now no description")
                locationReceived_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[2] != nil){
                let image = data.imageDictionary[2]
                let imageKey = NSUUID().UUIDString
                pONumber_ImagePath = imageKey
                imageStore.setImage(image!, forKey: pONumber_ImagePath)
                print("!!!!!!!!image \(image) set for key \(pONumber_ImagePath)")
            }else{
                pONumber_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[3] != nil){
                let image = data.imageDictionary[3]
                let imageKey = NSUUID().UUIDString
                weight_ImagePath = imageKey
                imageStore.setImage(image!, forKey: weight_ImagePath)
                print("!!!!!!!!image \(image) set for key \(weight_ImagePath)")
            }else{
                weight_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[4] != nil){
                let image = data.imageDictionary[4]
                let imageKey = NSUUID().UUIDString
                bOLNuber_ImagePath = imageKey
                imageStore.setImage(image!, forKey: bOLNuber_ImagePath)
                print("!!!!!!!!image \(image) set for key \(bOLNuber_ImagePath)")
            }else{
                bOLNuber_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[100] != nil){
                let image = data.imageDictionary[100]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                rebate_ImagePath = imageKey
            }else{
                rebate_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[101] != nil){
                let image = data.imageDictionary[101]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                cost_ImagePath = imageKey
            }else{
                cost_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[102] != nil){
                let image = data.imageDictionary[102]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                dateReceived_ImagePath = imageKey
            }else{
                dateReceived_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[103] != nil){
                let image = data.imageDictionary[103]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                paymentDueDate_ImagePath = imageKey
            }else{
                paymentDueDate_ImagePath = "No Description"
            }
            
            if(data.imageDictionary[104] != nil){
                let image = data.imageDictionary[104]
                let imageKey = NSUUID().UUIDString
                imageStore.setImage(image!, forKey: imageKey)
                other_ImagePath = imageKey
            }else{
                other_ImagePath = "No Description"
            }
            
            let dateCreated = getCurrentDateTime()
            
            print("this is the stuff to be insterted")
            print("\(data.imageDictionary)")
            print("Created on \(dateCreated)")
            
            let query = "insert into receipts (\(field_Receipts_GoodsDescription_ImagePath), \(field_Receipts_LocationReceived_ImagePath), \(field_Receipts_PONumber_ImagePath), \(field_Receipts_Weight_ImagePath), \(field_Receipts_BOLNuber_ImagePath), \(field_Receipts_Rebate_ImagePath), \(field_Receipts_Cost_ImagePath), \(field_Receipts_DateReceived_ImagePath), \(field_Receipts_PaymentDueDate_ImagePath), \(field_Receipts_Other_ImagePath)) values ('\(goodsDescription_ImagePath)', '\(locationReceived_ImagePath)', '\(pONumber_ImagePath)', '\(weight_ImagePath)', '\(bOLNuber_ImagePath)', '\(rebate_ImagePath)', '\(cost_ImagePath)', '\(dateReceived_ImagePath)', '\(paymentDueDate_ImagePath)', '\(other_ImagePath)' );"
                  print(query)
            
            print("inserted?")
            
            
            if !database.executeStatements(query) {
                print("Failed to insert initial receipt data into the database.")
                print(database.lastError(), database.lastErrorMessage())
            }else{
                print("receipt keys inserted to database!")
            }
            
            print("inserted?")
            
            
            database.close()
        }
    }

    func insertPrefillData(prefillInfo: [String], prefillColumn:String) {
        // Open the database.
        if openDatabase() {
            
            
            for item in prefillInfo{
                
                let query = "insert into prefill (\(prefillColumn)) values ('\(item)');"
                print(query)
                print("was that a good query?")
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }else{
                    print(" inserted to prefill database!")
                }
                
            }
            
            
            database.close()
        }
    }
    
    func firstInsertPrefillData(prefillInfo: [String], prefillColumn:String) {
        // Open the database.
        if openDatabase() {
            
            for item in prefillInfo{
                
                let query = "insert into prefill (\(prefillColumn)) values ('\(item)');"
                print(query)
                print("was that a good query?")
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }else{
                    print(" inserted to prefill database!")
                }
                
            }
            
            
            database.close()
        }
    }
    
    func updatePrefillData(prefillInfo: [String], prefillColumn:String) {
        // Open the database.
        if openDatabase() {
            
            var index = 0
            for item in prefillInfo{
                if(index < 7){
                //let query = "UPDATE prefill SET \(prefillColumn) = '\(item)' WHERE \(field_Prefill_EntryNumber) = '\(index)';"
                index += 1
                //let query = "insert into prefill (\(prefillColumn)) values ('\(item)');"
                //print(query)
                print("was that a good query?")
                print(index)
                //try database.executeUpdate("update test set x = ? where y = ?", values: ["foo", "bar"])
                do{
                    try database.executeUpdate("UPDATE prefill SET \(prefillColumn) = ? WHERE \(field_Prefill_EntryNumber) = ?", values: ["\(item)", "\(index)"] )
                    print("UPDATE prefill SET \(prefillColumn) = ? WHERE \(field_Prefill_EntryNumber) = ?, values: [\(item), \(index)]")
                //    print("Failed to insert initial data into the database.")
                //    print(database.lastError(), database.lastErrorMessage())
                //}else{
                    print(" inserted to prefill database!")
                //}
                }
                catch{
                    //print("errorCould not open the database.")
                    //print(error)
                    print(self.database.lastError(), self.database.lastErrorMessage())
                }
                }
            }
            
            
            database.close()
        }
    }
    
    func updatePrefillDataOne(prefillInfo: String, prefillColumn:String, index:Int) {
 
        if openDatabase() {
            
            //let entryNumber = prefillInfo[0]
            
            //for item in prefillInfo{
                
                let query = "UPDATE prefill SET \(prefillColumn) = '\(prefillInfo)' WHERE \(field_Prefill_EntryNumber) = '\(index)';"
                print(query)
                print("was that a good query?")
                
                if !database.executeStatements(query) {
                    print("Failed to insert initial data into the database.")
                    print(database.lastError(), database.lastErrorMessage())
                }else{
                    print(" inserted to prefill database!")
                }
                
            //}
            
            database.close()
        }
    }
    
    ///////////
    ///
    ///  load
    ///
    ////////////
    
    func loadUsers() -> [User]! {
        var users: [User]!
        print("yoyoyoyoyo")
        if openDatabase() {
            let query = "select * from users order by \(field_Users_BussinessName) asc"
            print("after query")
            do {
                //print(database)
                let results = try database.executeQuery(query, values: nil)
                
                print(results)
                print(results.next())
                
                print("after results")
               
                while results.next() {
                    let user = User(businessName: results.stringForColumn(field_Users_BussinessName),
                                        facilityAddress: results.stringForColumn(field_Users_FacilityAddress),
                                        tinyImagePath: results.stringForColumn(field_Users_TinyImagePath),
                                        userPhoneNumber: results.stringForColumn(field_Users_UserPhoneNumber),
                                        userEmailAddress: results.stringForColumn(field_Users_UserEmailAddress),
                                        userSupervisorsName: results.stringForColumn(field_Users_UserSupervisorsName),
                                        userSupervisorsEmail: results.stringForColumn( field_Users_UserSupervisorsEmail) //,
                                        //userKey: Int(results.int(forColumn: field_Users_UserKey))
                    )
                    print("\(user)")
                    if users == nil {
                        users = [User]()
                    }
                    
                    users.append(user)
                }
                results.close()
                print("after while")
            }
            catch {
                print("error!!!")
                print(error)
            }
            database.close()
        }
        print("will return")
        return users
    }
    
    func loadReceipts() -> [Receipt]! {
        var receipts: [Receipt]!
        print("receipts yoyoyoyoyo")
        if openDatabase() {
            let query = "select * from receipts order by \(field_Receipts_GoodsDescription) asc"
            print(query)
            print("after query")
            do {
                
                let results = try database.executeQuery(query, values: nil)
                print(results)
                print("after results")
                
                
                while results.next() {
                    print("how many results?")
                    
                    
                    
                    let receipt = Receipt(goodsDescription: results.stringForColumn(field_Receipts_GoodsDescription),
                                          locationReceived: results.stringForColumn(field_Receipts_LocationReceived),
                                          pONumber: results.stringForColumn(field_Receipts_PONumber),
                                          weight: results.stringForColumn(field_Receipts_Weight),
                                          bOLNuber: results.stringForColumn(field_Receipts_BOLNuber),
                                          rebate: results.stringForColumn(field_Receipts_Rebate),
                                          cost: results.stringForColumn(field_Receipts_Cost),
                                          dateReceived: results.stringForColumn(field_Receipts_DateReceived),
                                          paymentDueDate: results.stringForColumn(field_Receipts_PaymentDueDate),
                                          other: results.stringForColumn(field_Receipts_Other),
                                          dateCreated: results.stringForColumn(field_Receipts_DateCreated),
                                          
                                          plusOne: results.stringForColumn(field_Receipts_Plus_One),
                                          plusTwo: results.stringForColumn(field_Receipts_Plus_Two),
                                          
                                          goodsDescription_ImagePath: results.stringForColumn(field_Receipts_GoodsDescription_ImagePath),
                                          locationReceived_ImagePath: results.stringForColumn(field_Receipts_LocationReceived_ImagePath),
                                          pONumber_ImagePath: results.stringForColumn(field_Receipts_PONumber_ImagePath),
                                          weight_ImagePath: results.stringForColumn(field_Receipts_Weight_ImagePath),
                                          bOLNuber_ImagePath: results.stringForColumn(field_Receipts_BOLNuber_ImagePath),
                                          rebate_ImagePath: results.stringForColumn(field_Receipts_Rebate_ImagePath),
                                          cost_ImagePath: results.stringForColumn(field_Receipts_Cost_ImagePath),
                                          dateReceived_ImagePath: results.stringForColumn(field_Receipts_DateReceived_ImagePath),
                                          paymentDueDate_ImagePath: results.stringForColumn(field_Receipts_PaymentDueDate_ImagePath),
                                          other_ImagePath: results.stringForColumn(field_Receipts_Other_ImagePath),
                                          
                                          plusOne_ImagePath: results.stringForColumn(field_Receipts_Plus_One_ImagePath),
                                          plusTwo_ImagePath: results.stringForColumn(field_Receipts_Plus_Two_ImagePath)
                    )
                    
                    print("\(receipt)")
                    //print("\(results.stringForColumn(field_Receipts_GoodsDescription_ImagePath))")
                    
                    if receipts == nil {
                        receipts = [Receipt]()
                    }
                    //if(receipt != nil){
                        receipts.append(receipt)
                    //}
                    
                }
                results.close()
                print("after while")
            }
            catch {
                print("error!!!")
                print(error)
            }
            database.close()
        }
        
        return receipts
    }
    /*
    func loadPictureKeys() -> [Receipt]! {
        var receipts: [Receipt]!
        print("receipts yoyoyoyoyo")
        if openDatabase() {
            let query = "select * from receipts order by \(field_Receipts_GoodsDescription) asc"
            print("after query")
            do {
                
                let results = try database.executeQuery(query, values: nil)
                print(results)
                print("after results")
                
                
                while results.next() {
                    /*
                    let receipt = Receipt(goodsDescription: results.stringForColumn(field_Receipts_GoodsDescription),
                                          locationReceived: results.stringForColumn(field_Receipts_LocationReceived),
                                          pONumber: results.stringForColumn(field_Receipts_PONumber),
                                          weight: results.stringForColumn(field_Receipts_Weight),
                                          bOLNuber: results.stringForColumn(field_Receipts_BOLNuber),
                                          rebate: results.stringForColumn(field_Receipts_Rebate),
                                          cost: results.stringForColumn(field_Receipts_Cost),
                                          dateReceived: results.stringForColumn(field_Receipts_DateReceived),
                                          paymentDueDate: results.stringForColumn(field_Receipts_PaymentDueDate),
                                          other: results.stringForColumn(field_Receipts_Other),
                                          dateCreated: results.stringForColumn(field_Receipts_DateCreated)
                    )
                    */
                    
                    let receipt = Receipt(goodsDescription: results.stringForColumn(field_Receipts_GoodsDescription),
                                          locationReceived: results.stringForColumn(field_Receipts_LocationReceived),
                                          pONumber: results.stringForColumn(field_Receipts_PONumber),
                                          weight: results.stringForColumn(field_Receipts_Weight),
                                          bOLNuber: results.stringForColumn(field_Receipts_BOLNuber),
                                          rebate: results.stringForColumn(field_Receipts_Rebate),
                                          cost: results.stringForColumn(field_Receipts_Cost),
                                          dateReceived: results.stringForColumn(field_Receipts_DateReceived),
                                          paymentDueDate: results.stringForColumn(field_Receipts_PaymentDueDate),
                                          other: results.stringForColumn(field_Receipts_Other),
                                          dateCreated: results.stringForColumn(field_Receipts_DateCreated)
                    )
                    
                    print("\(receipt)")
                    if receipts == nil {
                        receipts = [Receipt]()
                    }
                    //if(receipt != nil){
                    receipts.append(receipt)
                    //}
                    
                }
                results.close()
                print("after while")
            }
            catch {
                print("error!!!")
                print(error)
            }
            database.close()
        }
        
        return receipts
    }
    */
    
    func loadPrefill(prefillSection:String) -> [String]! {
        //var prefills:[String]!
        var prefills = [String]()
        print(prefillSection)
        print("pfpfyoyoyoyoyo")
        if openDatabase() {//field_Prefill_EntryNumber
            
            ///let query = "select goodsDescription_Prefill from prefill"
            let query = "select \(prefillSection) from prefill"
            print(query)
            print("after query")
            do {
                
                let results = try database.executeQuery(query, values: nil)
                print(results)
                print(results.next())
                var index = 0;
                while results.next() {//&& index < 7{
                    //let pre = results.stringForColumn(prefillSection)
                    let prefill = results.stringForColumn(prefillSection)
                    print("in prefill load while")
                    print("\(prefill)")
                    //if prefills == nil {
                    //    prefills = [String]()
                    //}
                    if(prefill != nil){
                        prefills.append(prefill)
                    }
                    index += 1
                }
                results.close()
                print("after prefill while loop")
            }
            catch {
                print("error!!!")
                print(error)
            }
            database.close()
        }
        return prefills
    }
    
    func loadPrefillRowNumbers() -> [String]! {
        var prefills:[String]!
        
        let prefillSection = field_Prefill_EntryNumber
        
        print(prefillSection)
        print("pfpfyoyoyoyoyo")
        
        if openDatabase() {//field_Prefill_EntryNumber
            
            ///let query = "select goodsDescription_Prefill from prefill"
            let query = "select \(prefillSection) from prefill"
            print(query)
            print("after query")
            do {
                
                let results = try database.executeQuery(query, values: nil)
                print(results)
                print(results.next())
                while results.next() {
                    //let pre = results.stringForColumn(prefillSection)
                    let prefill = results.stringForColumn(prefillSection)
                    print("in prefill while")
                    //print("\(prefill)")
                    if prefills == nil {
                        prefills = [String]()
                    }
                    if(prefill != nil){
                        prefills.append(prefill)
                    }
                }
                results.close()
                print("after prefill while loop")
            }
            catch {
                print("error!!!")
                print(error)
            }
            database.close()
        }
        return prefills
    }
}
