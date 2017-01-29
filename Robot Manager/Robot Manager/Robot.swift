//
//  Robot.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 1/26/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import UIKit;

class Robot {
    var name: String
    var photo: UIImage?
    var rating: Float
    var description: String
    
    //MARK: Initialization
    
    init?(name: String, photo: UIImage?, rating: Float) {
        self.name = name
        self.photo = photo
        self.rating = rating
        self.description = name
    }
}
