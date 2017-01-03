//
//  ViewController.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 1/2/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    //MARK: properties
    @IBOutlet weak var teamNameField: UITextField!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var teamStrength: UISlider!
    @IBOutlet weak var teamGameMode: UISegmentedControl!
    @IBOutlet weak var teamPhoto: UIImageView!
    
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
    @IBAction func chooseImage(_ sender: UITapGestureRecognizer) {
        // Hide the keyboard. - did not know this was needed...
        teamNameField.resignFirstResponder()
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .camera
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
}

