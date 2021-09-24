//
//  Step1MakeAClockController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 11/7/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//
//  Gather Materials

import UIKit

class Step1MakeAClockController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create header view
        tableView.tableHeaderView = HelperMethods.createHeaderView(title: "Gather materials")
        
        // Set up navbar navigation
        let (left, home, right) = HelperMethods.createNavigationButtons(item: self.navigationItem, vc: self)
        left.action = #selector(goBack)
        home.action = #selector(goHome)
        right.action = #selector(goNext)
        
        // Set up "next" and "back" button
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 140))
        tableView.tableFooterView = footerView
        
        // Initialize next/back
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "2")
        navigationController?.pushViewController(vc!, animated: true)
        
        // Update saved state
        UserDefaults.standard.set(3, forKey: "page")
    }
    
    /**
     Returns the current View Controller to the first instructional page.
     */
    @objc func goBack() {
        // Remove saved states
        UserDefaults.standard.set(1, forKey: "page")
        UserDefaults.standard.removeObject(forKey: "page")
        
        navigationController?.popViewController(animated: true)
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
//    // Set section title
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if section == 0 {
//            return "Materials"
//        } else {
//            return ""
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
//        if section != 0 {
//            let label = view as! UITableViewHeaderFooterView
//            label.textLabel?.font = UIFont(name: "Raleway-Medium", size: 20)
//            label.textLabel?.numberOfLines = 0
//            label.textLabel?.textAlignment = .center
//            label.textLabel?.textColor = .black
//        }
//    }
    
//    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        if section != 0 {
//            return 60
//        } else {
//            return 0
//        }
//    }
    
//    //Footer height
//    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        if section != 0 {
//            return 40
//        } else {
//            return 0
//        }
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return super.tableView(tableView, heightForRowAt: indexPath)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let attributedString = NSMutableAttributedString()
            
        attributedString.mutableString.setString(paragraphs[indexPath.row])
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        // Configuring general cell layouts
        
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30)
        
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .left
        cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: (cell.textLabel?.font.pointSize)!)
        
        // Configures blue text for links
        if indexPath.row == 1 {
            cell.isUserInteractionEnabled = true
            cell.textLabel?.textColor = .black
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 2, length: 23))
        } else if indexPath.row == 2 {
            cell.isUserInteractionEnabled = true
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 2, length: 41))
        } else if indexPath.row == 3 {
            cell.isUserInteractionEnabled = true
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 2, length: 32))
        } else if indexPath.row == 4 {
            cell.isUserInteractionEnabled = true
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 6, length: 20))
        } else if indexPath.row == 5 {
            cell.isUserInteractionEnabled = true
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.systemBlue, range: NSRange(location: 2, length: 32))
        } else {
            cell.isUserInteractionEnabled = false
            cell.textLabel?.textColor = .black
        }
        
        // Set string
        cell.textLabel?.attributedText = attributedString
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.row < 6 && indexPath.row > 0 { // open link
            if let url = URL(string: links[indexPath.row - 1]) { // if there's no link, do nothing
                UIApplication.shared.open(url)
            }
        }
    }
    
    
    var paragraphs = ["Here is a list of the physical parts needed to a build your Climate Clock. Links to some parts are included to order them online:", "\u{2022} Raspberry Pi 3 Model B+ (other recent models may also work)", "\u{2022} Adafruit RGB Matrix + Real Time Clock HAT", "\u{2022} Brass M2.5 Standoffs for Pi HATs (optional)", "\u{2022} 1–3 64x32 RGB LED Matrix panels (3–6mm pitch)", "\u{2022} 5V 4000mA Switching Power Supply", "\u{2022} CR1220 3V battery", "\u{2022} Soldering iron", "\u{2022} Rosin core solder (also called flux core solder)", "\u{2022} MicroSD memory card, 4GB or larger (make sure you don't need its contents!)", "\u{2022} Computer running Mac OS, Windows, or Linux, with a MicroSD card reader or slot", "\u{2022} Ethernet cable connection to the internet"]
    
    var links = ["https://www.adafruit.com/product/3775", "https://learn.adafruit.com/adafruit-rgb-matrix-plus-real-time-clock-hat-for-raspberry-pi", "https://www.adafruit.com/product/2336", "https://www.adafruit.com/product/2279", "https://www.adafruit.com/product/1466"]
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
