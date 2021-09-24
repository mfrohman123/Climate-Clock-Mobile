//
//  ViewController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 9/22/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved. Nah they aren't lmao.
//

// TODO: Implement Tonnes left (this VC)
// TODO: Implement Lifeline (this VC)
// TODO: Implement Sliding predictions (Separate VC)
// TODO: Implement News cycle (this VC)
// TODO: Implement Resources pace, mackenzie allen (Separate VC)

import UIKit

class MainViewController: UIViewController {
    
    // Outlets
    @IBOutlet var years : UILabel!
    @IBOutlet var days : UILabel!
    @IBOutlet var time : UILabel!
    
    // Emission-calculation variables
    let SECONDS_PER_YEAR = 365.25 * 24 * 3600
    var START_DATE : Date!
        //python equivalent: datetime(2018, 1, 1, 0, 0, 0, tzinfo=timezone.utc)
    let START_EMISSIONS_BUDGET = 4.2e11
    let START_EMISSIONS_YEARLY = 4.2e10
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up START_DATE
        let calendar = Calendar(identifier: .gregorian)
        let dateComp = DateComponents(year: 2018, month: 1, day: 1)
        START_DATE = calendar.date(from: dateComp)
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy dd hh:mm:ss"
        
        print(formatter.string(from: START_DATE))
        
        DispatchQueue.global().async {
            while(1 == 1) { // Keep doing this
                self.getTimeLeft()
            }
        }
    }

    func getTimeLeft() {
        let now = Date()
        let emissions_per_second = START_EMISSIONS_YEARLY / SECONDS_PER_YEAR
        let emissions_budget_spent = (Double(now.timeIntervalSinceNow - START_DATE.timeIntervalSinceNow) * emissions_per_second)
        let emissions_budget = START_EMISSIONS_BUDGET - emissions_budget_spent
        print("emissions remaining:", emissions_budget)
        let time_remaining = emissions_budget / emissions_per_second
        
        let TI_tr = Date(timeIntervalSinceNow: TimeInterval(exactly: time_remaining)!)
        
        let diff = Double(TI_tr.timeIntervalSinceNow - now.timeIntervalSinceNow)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy dd hh:mm:ss"
        let date = Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: TI_tr)
        let y = (diff / 60 / 60 / 24 / 365)
        let divisor = 60 * 60 * 24 * 365
        let d = (diff.remainder(dividingBy: Double(divisor))) / 60 / 60 / 24
        let h = (diff.remainder(dividingBy: Double(divisor))) / 60 / 60 / 24
        
        let diffComp = Calendar.current.dateComponents([.year, .day, .hour, .minute, .second], from: now, to: TI_tr)
        
        DispatchQueue.main.async {
            let diff = (diffComp.hour! - 5 < 0) ? (diffComp.hour! + 24 - 5) : diffComp.hour! - 5
            self.years.text = String(diffComp.year!)
            self.days.text = String(format: "%03ld", diffComp.day!)
            let timeString = String(format: "%02ld:%02ld:%02ld", diff, diffComp.minute!, diffComp.second!)
            self.time.text = timeString
        }
        
        
        
//        print(diff, "y:", y, "d:", Int(d), "h:", h)
//        print("Year:", diff / 60 / 60 / 24 / 365, "day:", diff / 60 / 60 / 24, "hour:", diff / 60 / 60, "minute", diff / 60, "second", diff)
        
//        print("time left:", time_remaining)
//        print("budget", emissions_budget)
        
    }

}

