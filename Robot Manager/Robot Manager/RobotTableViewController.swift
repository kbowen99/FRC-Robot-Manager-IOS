//
//  RobotTableViewController.swift
//  Robot Manager
//
//  Created by Kurt Bowen on 1/26/17.
//  Copyright © 2017 Kurt Bowen. All rights reserved.
//

import UIKit

class RobotTableViewController: UITableViewController {
    //MARK: Properties
    var Robots = [Robot]();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleRobots();
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Robots.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "RobotTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RobotTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        // Fetches the appropriate meal for the data source layout.
        let robo = Robots[indexPath.row]
        
        cell.teamName.text = robo.name
        cell.teamPhoto.image = robo.photo
        cell.teamDesc.text = String(format:"%.2f", robo.rating)
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Private Methods
    
    private func loadSampleRobots() {
        let photo1 = UIImage(named: "defaultPic")
        let photo2 = UIImage(named: "defaultPic")
        let photo3 = UIImage(named: "defaultPic")
        
        guard let r1 = Robot(name: "Wildstang", photo: photo1, rating: 40) else {
            fatalError("Unable to instantiate meal1")
        }
        
        guard let r2 = Robot(name: "Mars Wars", photo: photo2, rating: 50) else {
            fatalError("Unable to instantiate meal2")
        }
        
        guard let r3 = Robot(name: "Foximus Prime", photo: photo3, rating: 10) else {
            fatalError("Unable to instantiate meal2")
        }
        Robots += [r1, r2, r3]
    }
    
    @IBAction func unwindToRobotList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? RobotViewController, let meal = sourceViewController.robo {
            
            // Add a new meal.
            let newIndexPath = IndexPath(row: Robots.count, section: 0)
            
            Robots.append(meal)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
    }

}
