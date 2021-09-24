//
//  Step3MakeAClockController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 11/7/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//
//  Attach the HAT and battery

import UIKit

class Step3MakeAClockController: UITableViewController {
    
    var images = [UIImage(named: "Step3Materials"), UIImage(named: "Step3Middle"), UIImage(named: "Step3Finished")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Create header view
        tableView.tableHeaderView = HelperMethods.createHeaderView(title: "Attach the HAT and battery")
        
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "4")
        navigationController?.pushViewController(vc!, animated: true)
        
        // Update saved state
        UserDefaults.standard.set(5, forKey: "page")
    }
    
    /**
     Returns the current View Controller to the first instructional page.
     */
    @objc func goBack() {
        // Remove saved states
        UserDefaults.standard.set(3, forKey: "page")
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        }
        return 3
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 1 {
            return "Steps:"
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
        if indexPath.row == 0 && indexPath.section == 0 { // First image
            return images[0]!.aspectRatio() * (view.bounds.width - 50)
        } else if indexPath.section == 1 && indexPath.row == 1 { // Second Image
            return images[1]!.aspectRatio() * (view.bounds.width - 50)
        }  else if indexPath.section == 1 && indexPath.row == 2 { // Third Image
            return images[2]!.aspectRatio() * (view.bounds.width - 50)
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let attributedString = NSMutableAttributedString()
        
        // Show banner
        let iv = UIImageView(frame: CGRect(x: 10, y: 0, width: view.bounds.width - 20, height: view.bounds.width - 60))
        iv.contentMode = .scaleAspectFit
        iv.tag = 64
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:))))
        
        cell.selectionStyle = .none
        cell.isUserInteractionEnabled = true
        
        // Configure banner
        if indexPath.section == 0 && indexPath.row == 0 { // First Image
            iv.image = images[0]
            cell.contentView.addSubview(iv)
            cell.contentView.clipsToBounds = true
        } else if indexPath.section == 1 && indexPath.row == 1 { // Second Image
            iv.image = images[1]
            cell.contentView.addSubview(iv)
            cell.contentView.clipsToBounds = true
        } else if indexPath.section == 1 && indexPath.row == 2 { // Third Image
            iv.image = images[2]
            cell.contentView.addSubview(iv)
            cell.contentView.clipsToBounds = true
        } else {
            cell.imageView?.image = nil
            cell.contentView.viewWithTag(64)?.removeFromSuperview()
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points
        
        // Set string
        if indexPath.section == 0 && indexPath.row == 1 {
            attributedString.mutableString.setString(paragraphs[0])
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = .darkGray
        } else if indexPath.section == 1 && indexPath.row == 0 {
            attributedString.mutableString.setString(paragraphs[1])
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = .black
        } else {
            cell.textLabel?.attributedText = nil
            cell.textLabel?.textColor = .darkGray
        }
        
        // Configuring general cell layouts
        
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30)
        
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .left
        
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
        } else {
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 17)
        }
        
        return cell
    }
    
    var paragraphs = ["Materials: \n \u{2022} Raspberry Pi 3 Model B+\n \u{2022} Fully-assembled RGB Matrix HAT\n \u{2022} CR1220 3V battery\n \u{2022} Brass M2.5 Standoffs for Pi HATs (optional)\n\nThe Raspberry Pi does not, by itself, have a way to remember the date and time while switched off, but the HAT provides this capability with a small quartz crystal clock powered by a battery. When attached to the GPIO pins of the Pi, the HAT will also supply the Pi with power.", "\u{2022} Screw the optional standoffs to the HAT for stability and plug its 40-pin header to the 40 GPIO (general-purpose input/output) pins on the Raspberry Pi. Insert the coin cell battery with its + side facing up."]

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
