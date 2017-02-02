//
//  Robot.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 1/26/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import UIKit;
import os.log;

class Robot: NSObject, NSCoding  {
    var name: String
    var photo: UIImage?
    var rating: Float
    var desc: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bots")
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Float) {
        self.name = name
        self.photo = photo
        self.rating = rating
        self.desc = name
    }
    
    //Data Structure Decoding
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        // Because photo is an optional property of Meal, just use conditional cast.
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        
        let rating = aDecoder.decodeFloat(forKey: PropertyKey.rating)
        
        // Must call designated initializer.
        self.init(name: name, photo: photo, rating: rating)
        
    }
    
    //Data Structure? encoding
    struct PropertyKey {
        static let name = "name"
        static let photo = "photo"
        static let rating = "rating"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(rating, forKey: PropertyKey.rating)
    }
}
