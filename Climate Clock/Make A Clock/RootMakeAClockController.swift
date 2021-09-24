//
//  MakeAClockRootController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 11/7/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//
//  This is the template for setting up the navigation page for guiding a user through creating their own Climate Clock.

import UIKit

class RootMakeAClockController: UITableViewController {
    
    let titles = ["How do I Make a Climate Clock?", "Gather Materials", "Assemble the RGB Matrix HAT", "Attach the HAT and battery", "Attach the RGB Matrix panels", "Prepare the software", "Turn it on!", "Share your Climate Clock"]
    
    var lastStep = UserDefaults.standard.value(forKey: "page") as? Int ?? 0

    /// Overriden view to set up the root "Make a Clock" View Controller.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Make a Clock!"
        
    }
    
    /// Overriden view to configure the UI to display how far into the guide the user is.
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        lastStep = UserDefaults.standard.value(forKey: "page") as? Int ?? 0
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    /// Configures number of sections in UITableViewController.
    /// - Returns: The number of sections of the index.
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Configures the height of rows in UITableViewController.
    /// - Returns: 110 if the row is for directing the user to the View Controller for sharing the finished Climate Clock, 90 otherwise.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 7 {
            return 110
        } else {
            return 90
        }
    }

    /// Configures the number of rows in UITableViewController.
    /// - Returns: The total number of steps, plus the View Controller for sharing the finished Climate Clock.
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    /// Configures the functionality for returning to the home screen.
    @IBAction func close() {
        self.dismiss(animated: true, completion: nil)
    }

    /// Configures the individual cells for the index.
    /// - Returns: The finished cell for each step, or the finished cell for the View Controller for sharing the finished Climate Clock.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = titles[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = UIFont(name: "Raleway-Medium", size: (cell.textLabel?.font.pointSize)!)
        
        
        // For "Share" button
        if indexPath.row == 7 {
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.font = UIFont(name: "Raleway-Medium", size: (20))
        } else { // Add arrows for rest of rows
            let iv = UIImageView(image: UIImage(named: "arrow")?.withRenderingMode(.alwaysTemplate))
            iv.tintColor = .black
            cell.accessoryView = iv
        }
        
        // For tracking completion
        if indexPath.row < lastStep {
            cell.textLabel?.textColor = .gray
            cell.accessoryView?.tintColor = .gray
            cell.imageView?.image = UIImage(named: "complete")?.withRenderingMode(.alwaysTemplate)
            cell.imageView?.tintColor = .darkGray
        } else {
            cell.textLabel?.textColor = .black
            cell.accessoryView?.tintColor = .black
            cell.imageView?.image = nil
            
            if indexPath.row == 7 {
                cell.textLabel?.textColor = .systemBlue
            }
        }

        return cell
    }
    
    /// Configures the action of individual cells for the index or View Controller for sharing.
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var count = 1
        var vc = storyboard?.instantiateViewController(withIdentifier: "Intro")
        var controllers = self.navigationController?.viewControllers
        controllers!.append(vc!)
        
        for i in stride(from: 0, to: min(indexPath.row, 6), by: 1) {
            vc = storyboard?.instantiateViewController(withIdentifier: "\(i + 1)")
            
            count += 1
            
            controllers!.append(vc!)
        }
        
        if indexPath.row == 7 {
            vc = storyboard?.instantiateViewController(withIdentifier: "Camera")
            controllers!.append(vc!)
        }
        
        self.navigationController?.setViewControllers(controllers!, animated: true)
        
        // Save state
        UserDefaults.standard.set(count, forKey: "page")
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
