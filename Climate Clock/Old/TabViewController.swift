//
//  TabViewController.swift
//  Climate Clock
//
//  Created by Matt Frohman on 9/22/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//

import UIKit

class TabViewController: UITabBarController {
    
    let titles = ["Clock", "Learn More"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabBar.selectedImageTintColor = .white
        UITabBar.appearance().unselectedItemTintColor = UIColor(hue: 0, saturation: 0, brightness: 1.0, alpha: 0.6)
        
        
        // Set bottom titles and images
        for num in 0...1 {
            self.tabBar.items![num].title = titles[num]
            self.tabBar.items![num].image = UIImage(named: titles[num])
            
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
