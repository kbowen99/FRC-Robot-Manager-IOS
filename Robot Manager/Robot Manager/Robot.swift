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
    @objc var teamNum: String = ""
    @objc var photo: UIImage?
    @objc var desc: String = ""
    //Tele Variables
    @objc var gameMode: Int = 0
    @objc var canShoot: Int = 0
    @objc var canGear: Int = 0
    @objc var driveTrain: Int = 0
    //Auto Vars
    @objc var autoLvl: Int = 0
    @objc var autoESR: Int = 0
    //Misc
    @objc var other: String
    
    @objc static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    @objc static let ArchiveURL = DocumentsDirectory.appendingPathComponent("bots")
    
    //MARK: Initialization
    @objc init?(teamNum: String, photo: UIImage?, gameMode: Int, shooter: Int, gears: Int, drive: Int, autoLvl: Int, autoESR: Int, misc: String) {
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
            os_log("Unable to decode the name for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let photo = aDecoder.decodeObject(forKey: PropertyKey.photo) as? UIImage else {
            os_log("Unable to decode the Photo for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let gameMode = aDecoder.decodeObject(forKey: PropertyKey.gameMode) as? String else {
            os_log("Unable to decode the GameMode for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let canShoot = aDecoder.decodeObject(forKey: PropertyKey.canShoot) as? String else {
            os_log("Unable to decode the Shooter for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let canGear = aDecoder.decodeObject(forKey: PropertyKey.canGear) as? String else {
            os_log("Unable to decode the Gear for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let driveTrain = aDecoder.decodeObject(forKey: PropertyKey.driveTrain) as? String else {
            os_log("Unable to decode the DriveTrain for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let autoLvl = aDecoder.decodeObject(forKey: PropertyKey.autoLvl) as? String else {
            os_log("Unable to decode the AutoLvl for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let autoESR = aDecoder.decodeObject(forKey: PropertyKey.autoESR) as? String else {
            os_log("Unable to decode the AutoESR for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        guard let other = aDecoder.decodeObject(forKey: PropertyKey.other) as? String else {
            os_log("Unable to decode the OTHER for a Robot object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(teamNum:teamNum, photo:photo, gameMode:Int(gameMode)!, shooter:Int(canShoot)!, gears:Int(canGear)!, drive:Int(driveTrain)!, autoLvl:Int(autoLvl)!, autoESR:Int(autoESR)!, misc:other);
        
    }
    
    //Data Structure? encoding
    struct PropertyKey {
        static let teamNum = "name"
        static let photo = "photo"
        static let gameMode = "gameMode"
        static let canShoot = "canShoot"
        static let canGear = "canGear"
        static let driveTrain = "driveTrain"
        static let autoLvl = "autoLvl"
        static let autoESR = "autoESR"
        static let other = "other"
    }
    
    func encode(with aCoder: NSCoder) {
        //let magic:String = "TRYING TO ENCODE: " + String(teamNum) + "|" + String(gameMode) + "|" + String(canShoot) + "|" + String(canGear) + "|" + String(driveTrain) + "|" + String(autoLvl) + "|" + String(autoESR) + "|" + String(other);
        //print(magic);
        //os_log(magic, log: OSLog.default, type: .debug)
        //aCoder.encodeCInt(Int32(gameMode), forKey: PropertyKey.gameMode)
        aCoder.encode(teamNum, forKey: PropertyKey.teamNum)
        aCoder.encode(photo, forKey: PropertyKey.photo)
        aCoder.encode(String(gameMode), forKey: PropertyKey.gameMode)
        aCoder.encode(String(canShoot), forKey: PropertyKey.canShoot)
        aCoder.encode(String(canGear), forKey: PropertyKey.canGear)
        aCoder.encode(String(driveTrain), forKey: PropertyKey.driveTrain)
        aCoder.encode(String(autoLvl), forKey: PropertyKey.autoLvl)
        aCoder.encode(String(autoESR), forKey: PropertyKey.autoESR)
        aCoder.encode(other, forKey: PropertyKey.other)
    }
    
}
