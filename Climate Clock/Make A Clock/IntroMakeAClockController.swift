//
//  MakeAClockIntroController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 11/7/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//
//  The View Controller for the introduction page.



import UIKit

class IntroMakeAClockController: UITableViewController {
    
    let image = UIImage(named: "banner")!

    /// Overriden view to set up the intro "Make a Clock" View Controller.
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up navbar navigation
        let (left, home, right) = HelperMethods.createNavigationButtons(item: self.navigationItem, vc: self)
        left.action = #selector(goBack)
        home.action = #selector(goHome)
        right.action = #selector(goNext)
        
        // Set up "next" and "back" button
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140))
        tableView.tableFooterView = footerView
        
        // Initialize next/back button functionality
        let (next, back) = HelperMethods.createBackAndNext(view: tableView!.tableFooterView!)
        back.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        next.addTarget(self, action: #selector(goNext), for: .touchUpInside)
    }
    
    /**
    Used for popping the View Controller to the home screen.
     */
    @objc func goHome() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    /// Displays a full-screen image based on a tap.
    /// - parameter sender: The UITapGestureRecognizer from a user tap.
    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        let previewVC = storyboard!.instantiateViewController(withIdentifier: "FullScreenHelper") as! FullScreenHelper
        previewVC.image = (sender.view as! UIImageView).image
        
        let navVC = UINavigationController()
        navVC.modalPresentationStyle = .fullScreen
        navVC.viewControllers = [previewVC]
        
        self.present(navVC, animated: true, completion: nil)
    }
    
    /**
     Advances the current View Controller to the first instructional page.
     */
    @objc func goNext() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "1")
        navigationController?.pushViewController(vc!, animated: true)
        
        // Update saved state
        UserDefaults.standard.set(2, forKey: "page")
    }
    
    /**
     Returns the current View Controller to the first instructional page.
     */
    @objc func goBack() {
        // Remove saved states
        UserDefaults.standard.removeObject(forKey: "page")
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section != 0 {
            return titles[section - 1]
        } else {
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if section != 0 {
            let label = view as! UITableViewHeaderFooterView
            label.textLabel?.font = UIFont(name: "Raleway-Medium", size: 22)
            label.textLabel?.numberOfLines = 0
            label.textLabel?.textAlignment = .center
            label.textLabel?.textColor = .black
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section != 0 {
            return 60
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section != 0 {
            return 40
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 1 && indexPath.section == 2 { // For link
            return 75
        } else if indexPath.section == 0 && indexPath.row == 0 { // For banner
            return view.bounds.width * self.image.aspectRatio()
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure text cells
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let attributedString = NSMutableAttributedString()
        
        // Show banner
        let iv = UIImageView(frame: CGRect(x: 10, y: 0, width: view.bounds.width - 20, height: view.bounds.width * self.image.aspectRatio()))
        iv.contentMode = .scaleAspectFit
        iv.image = image
        iv.tag = 64
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:))))
        
        // Configure banner
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.contentView.addSubview(iv)
            cell.contentView.contentMode = .top
            cell.contentView.clipsToBounds = true
        } else {
            cell.imageView?.image = nil
            
            cell.contentView.viewWithTag(64)?.removeFromSuperview()
        }
        
        if indexPath.section == 1 {
            attributedString.mutableString.setString(paragraphs[0])
        } else if indexPath.section != 0 {
            attributedString.mutableString.setString(paragraphs[indexPath.row + 1])
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // Configuring general cell layouts
        
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30)
        
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: (cell.textLabel?.font.pointSize)!)
        
        // Set string
        if indexPath.section != 0 {
            cell.textLabel?.attributedText = attributedString
        } else {
            cell.textLabel?.attributedText = nil
        }
        
        if indexPath.section == 2 && indexPath.row == 1 { // link
            cell.isUserInteractionEnabled = true
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = .systemBlue
        } else if indexPath.section == 0 && indexPath.row == 0 { // image
            cell.isUserInteractionEnabled = true
        } else {
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textColor = .black
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Open link
        if indexPath.section == 2 && indexPath.row == 1 {
            if let url = URL(string: "https://learn.adafruit.com/adafruit-guide-excellent-soldering") { // if there's no link, do nothing
                UIApplication.shared.open(url)
            }
        }
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

    var paragraphs = ["You can make your very own Climate Clock with some inexpensive electronics and six steps. They are: \n \u{2022} Gather materials\n \u{2022} Assemble the RGB Matrix HAT\n \u{2022} Attach the HAT and battery\n \u{2022} Attach the RGB Matrix panels\n \u{2022} Prepare the software\n \u{2022} Turn it on!\n\nOnce you've created your Climate Clock, take a photo and share it with the world to spread awareness!", "While having experience with electronics is always good, having none is fine! All you need to do is gather the proper materials and familiarize yourself with some basic concepts. One topic we recommend familiarizing yourself with is the concept of soldering - simply joining two metals by melting a third metal, using a special device called a soldering iron. If you haven't used a soldering iron before, please check out the link below before continuing.", "Adafruit's Excellent Guide to Soldering", "Practice a few solder joints to make sure you're up to speed. If you don't have spare electronics stuff at hand you can try paperclips, coins, keyrings, or other metal objects (avoid aluminum because its oxide layer makes it hard to solder)."]
    
    var titles = ["How Can I Make a Climate Clock?", "How Much Experience do I Need?"]
    
}
