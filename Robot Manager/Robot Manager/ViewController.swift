//
//  ViewController.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 1/2/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    //MARK: properties
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamStrength: UISlider!
    @IBOutlet weak var teamGameMode: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field’s user input through delegate callbacks.
        teamNameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: actions
    @IBAction func teamSubmit(_ sender: UIButton) {
        teamNameLabel.text = teamNameField.text! + "|" + String(format:"%.2f", (teamStrength.value * 100)) + "|" + teamGameMode.selectedSegmentIndex.description;
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        teamNameLabel.text = teamNameField.text
    }
}

