//
//  InfoViewController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 9/22/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = .black
        self.tableView.separatorStyle = .none
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
//        self.navigationController?.navigationBar.barStyle = .black
//        self.navigationController!.navigationBar.isTranslucent = true
//        self.setNeedsStatusBarAppearanceUpdate()
        
    }
    
    //Set page title
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Learn More"
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Raleway-Regular", size: 30)
        header.textLabel?.textAlignment = .center
        header.textLabel?.textColor = .white
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return paragraphs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.isUserInteractionEnabled = false
        
        let attributedString = NSMutableAttributedString(string: paragraphs[indexPath.row])
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 3 // Whatever line spacing you want in points
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: attributedString.length))
        
        if indexPath.row == paragraphs.count - 1 { // Add custom links
            cell.isUserInteractionEnabled = true
            cell.selectionStyle = .none
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(hex: 0x72bcd4), range: NSRange(location: 74, length: 18))
        }
        
        // Configuring general cell layouts
        cell.textLabel?.attributedText = attributedString
        
        cell.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        
//        cell.textLabel?.textColor = .white
        cell.textLabel?.font = UIFont(name: "Raleway-Regular", size: 20)
        
        cell.backgroundColor = .clear
        
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == paragraphs.count - 1 {
            loadPage()
        }
    }
    
    //Footer height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }

    // Helper for opening webpages
    @objc func loadPage() {
        if let url = URL(string: "https://climateclock.world") { // if there's no link, do nothing
            UIApplication.shared.open(url)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    let paragraphs = ["This Climate Clock shows one number: a timer, counting down how long it will take, at current rates of emissions, to burn through our “carbon budget” — the amount of CO2 that can still be released into the atmosphere while limiting global warming to 1.5°C above pre-industrial levels. This is our deadline, the time we have left to take decisive action to keep warming under the 1.5°C threshold.", "This clock follows the methodology of the carbon clock made by the Mercator Research Institute on Global Commons and Climate Change (MCC) which uses data from the recent IPCC Special Report on Global Warming of 1.5°C. The report states that starting from 2018, a carbon dioxide budget of 420 Gt of CO2 gives us a 67% chance to stay under 1.5°C of warming.", "“The concept of the carbon budget is based on a nearly linear relationship between the cumulative emissions and the temperature rise. Nevertheless, this does not mean that the earth would necessarily be 1.5⁰C warmer at the very point in time when the remaining carbon budget for staying below the 1.5⁰C threshold was used up. This is due to, among others, the fact that there is a time lag between the concentration of emissions in the atmosphere and the impact thereof on the temperature”.¹", "MCC also notes that their calculations assume “that the annual emissions of years to come will be close to those of the year 2017, while latest numbers show that emissions are still on the rise.” If this trend continues, the time we have to act will be reduced. Furthermore, it is unlikely that earth’s climate warms at a linear rate. For example, potential climatic tipping points have been identified in Earth’s physical climate system that would cause large and possibly irreversible transitions in the state of the climate.² These uncertainties are why the IPCC report states there is a 67% chance that the carbon budget will limit warming to 1.5°C.", "The IPCC Special Report on Global Warming is largely based on a research paper called “Global Carbon Budget 2018” published in 2018 by Corinne Le Quéré et al.³ This paper estimates the carbon budget in the units of GtC.⁴", "To learn more, including how to make your own Climate Clock, please visit climateclock.world"]

}

//For allowing hex initializations. This is silly. Why doesn't Swift let you do this?
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(hex: Int) {
        self.init(
            red: (hex >> 16) & 0xFF,
            green: (hex >> 8) & 0xFF,
            blue: hex & 0xFF
        )
    }
}
