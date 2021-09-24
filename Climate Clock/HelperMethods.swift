//
//  HelperMethods.swift
//  Climate Clock
//
//  Created by Matt Frohman on 11/12/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//
//  A Helper class that provides several methods to provide UI elements to a given view

import UIKit

class HelperMethods: NSObject {
    
    /// Creates the "Next" and "Back" buttons for a given view.
    /// - parameter view: The UIView to place buttons in, usually a UITableView Footer View.
    /// - Returns: A tuple of the left, home, and right bar buttons.
    static func createBackAndNext(view : UIView) -> (UIButton, UIButton) {
        
        // Create Next button
        let nextButton = UIButton(type: .system)
        nextButton.frame = CGRect(x: view.frame.width/2 + (view.frame.width/2 - 150) / 2, y: 40, width: 150, height: 60)
        nextButton.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 22)
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(.white, for: .normal)//UIColor(hue: 0, saturation: 0, brightness: 0.95, alpha: 1.0), for: .normal)
        view.addSubview(nextButton)
        nextButton.layer.cornerRadius = 5
        nextButton.backgroundColor = .blue
        
        // Create Back button
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: (view.frame.width/2 - 150) / 2, y: 40, width: 150, height: 60)
        backButton.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 22)
        backButton.setTitle("Back", for: .normal)
        backButton.setTitleColor(.white, for: .normal)
        view.addSubview(backButton)
        backButton.layer.cornerRadius = 5
        backButton.backgroundColor = .blue
        
        return (nextButton, backButton)
    }
    
    /// Creates the back, home, and next bar buttons for each input navigation item.
    /// - parameter item: The UINavigationItem to create the bar buttons for.
    /// - parameter vc: The View Controller to be the target.
    /// - Returns: A tuple of the left, home, and right bar buttons.
    static func createNavigationButtons(item : UINavigationItem, vc: UIViewController) -> (UIBarButtonItem, UIBarButtonItem, UIBarButtonItem) {
        
        let left = UIBarButtonItem(image: UIImage(named: "back"), style: .plain, target: vc, action: nil)
        let home = UIBarButtonItem(image: UIImage(named: "home"), style: .plain, target: vc, action: nil)
        let right = UIBarButtonItem(image: UIImage(named: "next"), style: .plain, target: vc, action: nil)
        
        item.leftBarButtonItems = [left, home]
        item.rightBarButtonItem = right
        
        return (left, home, right)
    }
    
    /// Creates the header view.
    /// - parameter title: Input string of the title.
    /// - Returns: The UIView to be used as a UITableView header.
    static func createHeaderView(title : String) -> UIView {
        
        // Set up selection view
        let selectionView = UIView(frame: CGRect(x: 10, y: 0, width: UIScreen.main.bounds.width - 20, height: 100))
        let descriptionLabel = UILabel()
        selectionView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: selectionView.topAnchor, constant: 25).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 40).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: selectionView.leftAnchor, constant: 20).isActive = true
        descriptionLabel.font = UIFont(name: "Raleway-Medium", size: 32)
        descriptionLabel.adjustsFontSizeToFitWidth = true
        descriptionLabel.textColor = .black
        descriptionLabel.textAlignment = .center
        descriptionLabel.text = title
        
        return selectionView
    }

}
