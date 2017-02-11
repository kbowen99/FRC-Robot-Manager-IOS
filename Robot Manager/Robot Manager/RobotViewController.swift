//
//  RobotViewController.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 1/2/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import UIKit
import os.log

class RobotViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: properties
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamPhoto: UIImageView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var shooterSelector: UISegmentedControl!
    @IBOutlet weak var gameSelector: UISegmentedControl!
    @IBOutlet weak var gearSelector: UISegmentedControl!
    @IBOutlet weak var driveSelector: UISegmentedControl!
    @IBOutlet weak var AutoSelector: UISegmentedControl!
    @IBOutlet weak var AutoSlider: UISlider!
    @IBOutlet weak var notesField: UITextField!
    
    //Current Robot
    var robo:Robot?
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        let name = teamNameField.text ?? ""
        let photo = teamPhoto.image
        //let rating:Float = 0.0
        
        // Set the meal to be passed to MealTableViewController after the unwind segue.
        //(teamNum:teamNum, photo:photo, gameMode:gameMode, shooter:canShoot, gears:canGear, drive:driveTrain, autoLvl:autoLvl, autoESR:autoESR, misc:other)
        robo = Robot(teamNum:name, photo:photo, gameMode:gameSelector.selectedSegmentIndex, shooter:shooterSelector.selectedSegmentIndex, gears:gearSelector.selectedSegmentIndex, drive:driveSelector.selectedSegmentIndex, autoLvl:AutoSelector.selectedSegmentIndex, autoESR:Int(AutoSlider.value * 100), misc:notesField.text!)
    }
    
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        //dismiss(animated: true, completion: nil)
        let isPresentingInAddRobotMode = presentingViewController is UINavigationController
        
        if isPresentingInAddRobotMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The RobotViewController is not inside a navigation controller.")
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        // Handle the text field’s user input through delegate callbacks.
        teamNameField.delegate = self
        updateSaveButtonState()
        
        //Load Robot
        if let robo = robo {
            navigationItem.title = robo.teamNum
            teamNameField.text   = robo.teamNum
            teamPhoto.image = robo.photo
            shooterSelector.selectedSegmentIndex = robo.canShoot
            gearSelector.selectedSegmentIndex = robo.canGear
            gameSelector.selectedSegmentIndex = robo.gameMode
            driveSelector.selectedSegmentIndex = robo.driveTrain
            AutoSelector.selectedSegmentIndex = robo.autoLvl
            AutoSlider.value = Float(Double(robo.autoESR) / 100.0)
            notesField.text = robo.other
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        teamPhoto.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField){
        updateSaveButtonState()
        navigationItem.title = textField.text
    }
    @IBAction func chooseImage(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard. - did not know this was needed...
        teamNameField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // Disable the Save button while editing.
        saveButton.isEnabled = false
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        let text = teamNameField.text ?? ""
        saveButton.isEnabled = !text.isEmpty
    }
}

