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
    var teamNum: String
    var photo: UIImage?
    var desc: String
    //Tele Variables
    var gameMode: Int
    var canShoot: Int
    var canGear: Int
    var driveTrain: Int
    //Auto Vars
    var autoLvl: Int
    var autoESR: Int
    //Misc
    var other: String
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bots")
    
    //MARK: Initialization
    init?(teamNum: String, photo: UIImage?, gameMode: Int, shooter: Int, gears: Int, drive: Int, autoLvl: Int, autoESR: Int, misc: String) {
        self.teamNum = teamNum
        self.photo = photo
        self.gameMode = gameMode
        self.canShoot = shooter
        self.canGear = gears
        self.driveTrain = drive
        self.autoLvl = autoLvl
        self.autoESR = autoESR
        self.other = misc
        
        self.desc = "GM: " + (gameMode == 0 ? "D " : (gameMode == 1 ? "G " : (gameMode == 2 ? "LG " : "HG ")));
        self.desc += "SH: " + (canShoot == 0 ? "N " : (canShoot == 1 ? "L " : (canShoot == 2 ? "H " : "Y ")));
        self.desc += "GE: " + (canGear == 0 ? "N " : (canGear == 1 ? "M " : "Y "));
        self.desc += "DR: " + (driveTrain == 0 ? "Sketchy " : (driveTrain == 1 ? "Precise " : "Fast "));
        self.desc += "Auto: " + (autoLvl == 0 ? "None " : (autoLvl == 1 ? "Line " : (autoLvl == 2 ? "Low " : (autoLvl == 3 ? "High " : (autoLvl == 4 ? "Gear " : "Yes ")))));
        self.desc += "OTHER: " + misc;
    }
    
    //Data Structure Decoding
    required convenience init?(coder aDecoder: NSCoder) {
        guard let teamNum = aDecoder.decodeObject(forKey: PropertyKey.teamNum) as? String else {
            os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            return nil
        }
        let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage
        let gameMode = aDecoder.decodeObject(forKey: PropertyKey.gameMode) as! Int
        let canShoot = aDecoder.decodeObject(forKey: PropertyKey.canShoot) as! Int
        let canGear = aDecoder.decodeObject(forKey: PropertyKey.canGear) as! Int
        let driveTrain = aDecoder.decodeObject(forKey: PropertyKey.driveTrain) as! Int
        let autoLvl = aDecoder.decodeObject(forKey: PropertyKey.autoLvl) as! Int
        let autoESR = aDecoder.decodeObject(forKey: PropertyKey.autoESR) as! Int
        let other = aDecoder.decodeObject(forKey: PropertyKey.other) as! String
        self.init(teamNum:teamNum, photo:photo, gameMode:gameMode, shooter:canShoot, gears:canGear, drive:driveTrain, autoLvl:autoLvl, autoESR:autoESR, misc:other);
        
    }
    
    //Data Structure? encoding
    struct PropertyKey {
        static let teamNum = "name"
        static let photo = "photo"
        static let gameMode = "gm"
        static let canShoot = "canShoot"
        static let canGear = "canGear"
        static let driveTrain = "driveTrain"
        static let autoLvl = "autoLvl"
        static let autoESR = "autoESR"
        static let other = "other"
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(teamNum, forKey: PropertyKey.teamNum)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(gameMode, forKey: PropertyKey.gameMode)
        aCoder.encode(canShoot, forKey: PropertyKey.canShoot)
        aCoder.encode(canGear, forKey: PropertyKey.canGear)
        aCoder.encode(driveTrain, forKey: PropertyKey.driveTrain)
        aCoder.encode(autoLvl, forKey: PropertyKey.autoLvl)
        aCoder.encode(autoESR, forKey: PropertyKey.autoESR)
        aCoder.encode(other, forKey: PropertyKey.other)
    }
}
