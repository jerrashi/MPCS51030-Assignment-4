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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        /*
        // Get screen dimensions
        // iphone 15 pro size: 852 x 393
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
         */
        
        // Create "X" and "O" UILabel Views
        let xLabel = UILabel(frame: CGRect(x: 16, y: 645, width: 131, height: 131))
        xLabel.text = "X"
        xLabel.textAlignment = .center
        xLabel.font = UIFont.systemFont(ofSize: 120, weight: .bold)
        xLabel.textColor = .white
        xLabel.backgroundColor = .blue
        xLabel.isUserInteractionEnabled = true
        
        let oLabel = UILabel(frame: CGRect(x: 246, y: 645, width: 131, height: 131))
        oLabel.text = "O"
        oLabel.textAlignment = .center
        oLabel.font = UIFont.systemFont(ofSize: 120, weight: .bold)
        oLabel.textColor = .white
        oLabel.backgroundColor = .red
        oLabel.isUserInteractionEnabled = true
        
        
        // Add Pan Gesture Recognizer
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        panGesture.delegate = self
        
        xLabel.addGestureRecognizer(panGesture)
        oLabel.addGestureRecognizer(panGesture)
        
        // Add views to view hierarchy
        self.view.addSubview(xLabel)
        self.view.addSubview(oLabel)
    }
    
    // MARK: - Gesture Metods
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer){
        let translation = gestureRecognizer.translation(in: self.view)
        
        if let view = gestureRecognizer.view{
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
        }
        
    }
}
