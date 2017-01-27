//
//  RobotTableViewCell.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 1/26/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import UIKit

class RobotTableViewCell: UITableViewCell {
    //MARK: Stuff From Real World
    
    @IBOutlet weak var teamDesc: UITextView!
    @IBOutlet weak var teamPhoto: UIImageView!
    @IBOutlet weak var teamName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
