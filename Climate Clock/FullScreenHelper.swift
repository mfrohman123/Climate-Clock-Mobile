//
//  FullScreenHelper.swift
//  Climate Clock
//
//  Created by Matt Frohman on 11/11/20.
//  Copyright © 2020 Matthew Frohman. All rights reserved.
//
//  The manager for handling the zoomable full-screen view of an image a user taps.

import UIKit

class FullScreenHelper: UIViewController, UIScrollViewDelegate {
    
    var scrollView : UIScrollView!
    var imageView : UIImageView!
    var image : UIImage! // Scrollable image, set by sending VC

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Configure title bar, UIScrollView for zooming/scrolling, and UIImageView to display fullscreen image
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(close))
        self.navigationController?.navigationBar.tintColor = .black
        
        scrollView = UIScrollView(frame: view.bounds)
        imageView = UIImageView(frame: view.bounds)
        scrollView.contentSize = CGSize(width: 2000, height: 2000)
        
        view.backgroundColor = .black

        imageView.contentMode = .scaleAspectFit
        scrollView.contentMode = .center
        
        imageView.image = image
        
        view.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        //set up image zooming
        scrollView.delegate = self
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.flashScrollIndicators()
    }
    
    /**
     User wants to exit the view.
     */
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
    
    /**
     Handler for zooming in/zooming out.
     */
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
       return self.imageView
    }
    
    /**
     Handler for centering a zoomed image.
     */
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let offsetX = max((scrollView.bounds.width - scrollView.contentSize.width) * 0.5, 0)
        let offsetY = max((scrollView.bounds.height - scrollView.contentSize.height) * 0.5, 0)
        scrollView.contentInset = UIEdgeInsets.init(top: offsetY, left: offsetX, bottom: 0, right: 0)
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

extension UIImage {
    /// Used to return the aspect ratio, in the form of height / width
    func aspectRatio() -> CGFloat {
        return self.size.height / self.size.width
    }
}
