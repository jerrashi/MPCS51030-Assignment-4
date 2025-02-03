//
//  ViewController.swift
//  Assignment 4
//
//  Created by Jerry Shi on 1/30/25.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // Set Up Outlets
    @IBOutlet var squares: [UIView]!
    // MARK: Do we need this outlet?
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var infoView: InfoView!
    @IBOutlet weak var infoViewLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        // Get screen dimensions
        // iphone 15 pro size: 852 x 393
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
         */
        
        // Keep infoView off screen to begin with
        infoView.frame.origin.y = -infoView.frame.height
        //infoView.center.x = self.view.frame.width / 2
        
        // TO DO: - Optional (create views in storyboard and add outlet to view controller)
        // Create "X" and "O" UILabel Views
        let xLabel = UILabel(frame: CGRect(x: 16, y: 645, width: 125, height: 125))
        xLabel.text = "X"
        xLabel.textAlignment = .center
        xLabel.font = UIFont.systemFont(ofSize: 120, weight: .bold)
        xLabel.textColor = .white
        xLabel.backgroundColor = .blue
        xLabel.isUserInteractionEnabled = true
        
        let oLabel = UILabel(frame: CGRect(x: 252, y: 645, width: 125, height: 125))
        oLabel.text = "O"
        oLabel.textAlignment = .center
        oLabel.font = UIFont.systemFont(ofSize: 120, weight: .bold)
        oLabel.textColor = .white
        oLabel.backgroundColor = .red
        oLabel.isUserInteractionEnabled = true
        
        // Add Pan Gesture Recognizer to X Label
        let xPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        xPanGesture.delegate = self
        xLabel.addGestureRecognizer(xPanGesture)
        
        // Add Pan Gesture Recognizer to O Label
        let oPanGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        oPanGesture.delegate = self
        oLabel.addGestureRecognizer(oPanGesture)
        
        // Add views to view hierarchy
        self.view.addSubview(xLabel)
        self.view.addSubview(oLabel)
        
        /// OPTIONAL: Enable tap gesture on infoView to dismiss alert screen
        /*
        // Add Tap Gesture Recognizer to infoView
        let infoViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(infoViewTapped(_:)))
        infoViewTapGesture.delegate = self
        infoView.addGestureRecognizer(infoViewTapGesture)
         */
        
    }
    
    // MARK: - Gesture Metods
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer){
        let translation = gestureRecognizer.translation(in: self.view)
        
        if let view = gestureRecognizer.view{
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
    }
    
    /*
    @objc func infoViewTapped(_ gestureRecognizer: UITapGestureRecognizer){
        if let view = gestureRecognizer.view{
            UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                // Move view from off screen to middle of screen vertically
                self.infoView.frame.origin.y = self.view.frame.height
            })
            {_ in
                // reset view to right above screen
                self.infoView.frame.origin.y = -self.infoView.frame.height
            }
        }
    }
    */
    
    // MARK: - Button Functions
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        // Update infoViewLabel text
        infoViewLabel.text = "Get 3 in a row to win!"
                
        // Animate infoView
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            // Move view from off screen to middle of screen vertically
            self.infoView.frame.origin.y = self.view.center.y - self.infoView.frame.height / 2
        })
    }
    
    @IBAction func infoViewButtonTapped(_ sender: UIButton) {
        // Animate infoView
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            // Move view from off screen to middle of screen vertically
            self.infoView.frame.origin.y = self.view.frame.height
        })
        {_ in
            // reset view to right above screen
            self.infoView.frame.origin.y = -self.infoView.frame.height
        }
    }
    
    
}
