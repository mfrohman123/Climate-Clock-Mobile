//
//  Step5MakeAClockController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 11/7/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//
//   Prepare the software

import UIKit

class Step5MakeAClockController: UITableViewController {
    
    var images = [UIImage(named: "Step5_1"), UIImage(named: "Step5_2"), UIImage(named: "Step5_3")]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.tableHeaderView = HelperMethods.createHeaderView(title: "Prepare the software")
        
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
        let vc = storyboard?.instantiateViewController(withIdentifier: "6")
        navigationController?.pushViewController(vc!, animated: true)
        
        // Update saved state
        UserDefaults.standard.set(7, forKey: "page")
    }
    
    /**
     Returns the current View Controller to the first instructional page.
     */
    @objc func goBack() {
        // Remove saved states
        UserDefaults.standard.set(5, forKey: "page")
        
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        }
        return 6
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
        if indexPath.section == 0 && indexPath.row == 2 { // First image
            return images[0]!.aspectRatio() * (view.bounds.width - 50)
        } else if indexPath.section == 1 && indexPath.row == 3 { // Second Image
            return images[1]!.aspectRatio() * (view.bounds.width - 50)
        } else if indexPath.section == 1 && indexPath.row == 5 { // Third Image
            return images[2]!.aspectRatio() * (view.bounds.width - 50)
        } else if indexPath.section == 0 && indexPath.row == 1 {
            return 75
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
        if indexPath.section == 0 && indexPath.row == 2 { // First Image
            iv.image = images[0]
            cell.contentView.addSubview(iv)
            cell.contentView.clipsToBounds = true
        } else if indexPath.section == 1 && indexPath.row == 3 { // Second Image
            iv.image = images[1]
            cell.contentView.addSubview(iv)
            cell.contentView.clipsToBounds = true
        } else if indexPath.section == 1 && indexPath.row == 5 { // Third Image
            iv.image = images[2]
            cell.contentView.addSubview(iv)
            cell.contentView.clipsToBounds = true
        } else {
            cell.imageView?.image = nil
            cell.contentView.viewWithTag(64)?.removeFromSuperview()
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4 // Whatever line spacing you want in points
        
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.textAlignment = .left
        
        // Set string
        if indexPath.section == 0 && indexPath.row == 0 {
            attributedString.mutableString.setString(paragraphs[0])
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = .black
        } else if indexPath.section == 0 && indexPath.row == 1 {
            attributedString.mutableString.setString(paragraphs[1])
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = .systemBlue
            cell.textLabel?.textAlignment = .center
        } else if indexPath.section == 0 && indexPath.row == 3 {
            attributedString.mutableString.setString(paragraphs[2])
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = .darkGray
        } else if indexPath.section == 1 && indexPath.row == 0 {
            attributedString.mutableString.setString(paragraphs[3])
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = .black
        } else if indexPath.section == 1 && indexPath.row == 1 {
           attributedString.mutableString.setString(paragraphs[4])
           attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
           cell.textLabel?.attributedText = attributedString
           cell.textLabel?.textColor = .black
        } else if indexPath.section == 1 && indexPath.row == 2 {
           attributedString.mutableString.setString(paragraphs[5])
           attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
           cell.textLabel?.attributedText = attributedString
           cell.textLabel?.textColor = .black
        } else if indexPath.section == 1 && indexPath.row == 4 {
            attributedString.mutableString.setString(paragraphs[6])
            attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
            cell.textLabel?.attributedText = attributedString
            cell.textLabel?.textColor = .black
        } else {
            cell.textLabel?.attributedText = nil
            cell.textLabel?.textColor = .darkGray
        }
        
        // Configuring general cell layouts
        
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: -30)
        
        
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 16)
        } else {
            cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 17)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        // Open link
        if indexPath.section == 0 && indexPath.row == 1 {
            if let url = URL(string: "https://github.com/BeautifulTrouble/climate-clock-kit/blob/master/instructions/instructions.md#prepare-the-software") {
                UIApplication.shared.open(url)
            }
        }
    }
    
    var paragraphs = ["NOTE: Please view the step below on your computer via the link below. You must download and install software from this link during this step.", "Link to GitHub version", "Materials: \n \u{2022} MicroSD memory card, 4GB or larger\n \u{2022} Computer running Mac OS, Windows, or Linux, with a MicroSD card reader or slot\n \u{2022} balenaEtcher for writing memory card images\n \u{2022} Climate Clock memory card image (see below)\n\nThis software includes a Linux operating system based on Raspbian, the official operating system from the Raspberry Pi Foundation, with some modifications to work with the HAT. The software also includes a Python program for controlling your Climate Clock. This program follows a simple methodology for calculating the 1.5°C global carbon budget.", "\u{2022} Download a Climate Clock memory card image to your computer.", "\u{2022} Install balenaEtcher, a tool for writing images to memory cards. If you prefer to use other tools (like dd), go right ahead and skip the following step. Be aware that just copying the image file onto the memory card, like by dragging the image file to the card's icon, will not work! It's important to copy the image with an appropriate tool.", "\u{2022} Copy the image: \n\u{25E6}Connect the MicroSD card reader with the card inside, or use your computer's MicroSD card slot.\n\u{25E6}Open balenaEtcher and select from your hard drive the Climate Clock .img file you downloaded.\n\u{25E6}Select the card you'll write the image to.\n\u{25E6}Click Flash!", "\u{2022} Safely remove or eject the MicroSD card and insert it into the slot on the underside of the Raspberry Pi."]

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
