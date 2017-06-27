//
//  ImageStore.swift
//  iReceivedIT
//
//  Created by Steven Kanceruk on 10/28/16.
//  Copyright © 2016 Steven Kanceruk Inc. All rights reserved.
//

import UIKit

class ImageStore {
    
    static let sharedInstance: ImageStore = ImageStore()
    
    let cache = NSCache()
    
    func setImage(image: UIImage, forKey key: String){
        print(image)
        print(key)
        print("this work?")
        
        // Ceate full URL for image
        let imageURL = imageURLForKey(key)
        print("image \(image) should be inserted at \(imageURL)")
        
        // Turn image into JPEG data
        if let data = UIImageJPEGRepresentation(image, 0.5){
            // Write it to full URL
            data.writeToURL(imageURL, atomically: true)
            print("now wrote to url")
        }
        
    }
    
    func imageForKey(key: String) -> UIImage?{
        
        print("image for key start")
        
        if let existingImage = cache.objectForKey(key) as? UIImage{
            print("is there an existing image?")
            return existingImage
        }
        
        let imageURL = imageURLForKey(key)
        
        print("image should be found at \(imageURL)")
        
        guard let imageFromDisk = UIImage(contentsOfFile: imageURL.path!) else{
            print("we got a nil")
            return nil
        }
        print("before cache")
        cache.setObject(imageFromDisk, forKey: key)
        print("after cache")
        return imageFromDisk
    }
    
    func deleteImageForKey(key:String){
        cache.removeObjectForKey(key)
        
        let imageURL = imageURLForKey(key)
        do{
            try NSFileManager.defaultManager().removeItemAtURL(imageURL)
        }catch let deleteError{
            print("Error removing the image from disk \(deleteError)")
        }
    }
    
    func imageURLForKey(key: String) -> NSURL {
        
        print("image URL for key start")
        
        let documentsDirectories = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory,
                                                                                   inDomains: .UserDomainMask)
        
        
        let documentDirectory = documentsDirectories.first!
        
        //if let docDir = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first,
        //    let filePath = docDir.URLByAppendingPathComponent("savedObject.data").filePathURL?.path{
        //}
        
        return documentDirectory.URLByAppendingPathComponent(key)!//.filePathURL?
    }
    
}
