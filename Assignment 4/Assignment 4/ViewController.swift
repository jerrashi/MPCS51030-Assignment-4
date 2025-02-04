//
//  ViewController.swift
//  Assignment 4
//
//  Created by Jerry Shi on 1/30/25.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {

    // Set Up Outlets
    @IBOutlet var squares: [UILabel]!
    @IBOutlet weak var infoView: InfoView!
    @IBOutlet weak var infoViewLabel: UILabel!
    @IBOutlet weak var xLabel: UILabel!
    @IBOutlet weak var oLabel: UILabel!
    @IBOutlet weak var customGridView: CustomGridView!
    
    var isXTurn = false
    var initialCenter: CGPoint = .zero
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Double check that grid is see through besides drawn lines
        customGridView.backgroundColor = .clear
        customGridView.isOpaque = false
        
        /*
        // screen dimensions
        // iphone 15 pro: 852 x 393
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
         */
        
        // Make sure infoView is off screen to begin with
        infoView.frame.origin.y = -infoView.frame.height
        //infoView.center.x = self.view.frame.width / 2
        
        // Modify "X" and "O" UILabel Views
        // let xLabel = UILabel(frame: CGRect(x: 16, y: 645, width: 125, height: 125))
        xLabel.text = "X"
        xLabel.textAlignment = .center
        xLabel.font = UIFont.systemFont(ofSize: 120, weight: .bold)
        xLabel.textColor = .white
        xLabel.backgroundColor = .blue
        xLabel.isUserInteractionEnabled = false
        
        // let oLabel = UILabel(frame: CGRect(x: 252, y: 645, width: 125, height: 125))
        oLabel.text = "O"
        oLabel.textAlignment = .center
        oLabel.font = UIFont.systemFont(ofSize: 120, weight: .bold)
        oLabel.textColor = .white
        oLabel.backgroundColor = .red
        oLabel.isUserInteractionEnabled = false
        
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
        
        // Set up x as first turn
        switchTurn()
        
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
        if let view = gestureRecognizer.view{
            switch gestureRecognizer.state{
            case .began:
                // TO-DO: Change view to snap to center of touch
                initialCenter = view.center
            case .changed:
                let translation = gestureRecognizer.translation(in: self.view)
                view.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
                // Note: We don't use this since we track from starting position, instead of cumulative movement
                //gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
            case .ended, .cancelled:
                // TO-DO: Implement logic to snap views
                for square in squares{
                    if square.frame.contains(view.center) /*&& grid.isEmpty(square: square.tag)*/ {
                        // Animate piece "snapping" into place
                        UIView.animate(withDuration: 1, animations: {
                            // Move view from off screen to middle of screen vertically
                            view.center = square.center
                        })
                        square.backgroundColor = isXTurn ? .blue : .red
                        square.textAlignment = .center
                        square.text = isXTurn ? "X" : "O"
                        square.font = UIFont.systemFont(ofSize: 120, weight: .bold)
                        square.textColor = UIColor.white
                        
                        // Update grid model
                        // grid[tag] = isXTurn ? "X" : "O"
                        
                        // Hide view so snap back to spot isn't visible
                        view.isHidden = true
                        
                        // Check for winner
                        //checkWinner()
                        
                        switchTurn()
                        }
                }
                
                // Animate piece snapping back to starting spot
                UIView.animate(withDuration: 0.25, animations: {
                    // Move view from off screen to middle of screen vertically
                    view.frame.origin.y = 645
                    // Unwrap view as UILabel
                    if let label = view as? UILabel {
                        if label.text == "X" {
                            label.frame.origin.x = 16
                        } else {
                            label.frame.origin.x = 252
                        }
                    }
                    else {
                        print("ERROR: View is NOT a Label")
                    }
                })
                
                // Make sure piece is no longer hidden
                view.isHidden = false
                
            default:
                break
            }
        }
        else {
            print("ERROR - gesture recognizer view not unwrapped")
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
    // Info button to bring infoView to center of screen
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        // Update infoViewLabel text
        infoViewLabel.text = "Get 3 in a row to win!"
        
        // Make sure infoView is on top of stack
        self.view.bringSubviewToFront(infoView)
                
        // Animate infoView
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            // Move view from off screen to middle of screen vertically
            self.infoView.frame.origin.y = self.view.center.y - self.infoView.frame.height / 2
        })
    }
    
    // OK button to move infoView to below screen
    @IBAction func infoViewButtonTapped(_ sender: UIButton) {
        // Make sure infoView is on top of stack
        self.view.bringSubviewToFront(infoView)
        
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
    
    // MARK: -Gameplay Functions
    func switchTurn() {
        // Store current piece
        let oldPiece = isXTurn ? xLabel : oLabel
        let newPiece = isXTurn ? oLabel : xLabel
        
        // Switch isXTurn value
        isXTurn.toggle()

        // Disable old piece
        oldPiece?.alpha = 0.25
        oldPiece?.isUserInteractionEnabled = false
        
        // Animate & Enable new piece
        newPiece?.alpha = 1
        UIView.animate(withDuration: 0.25, animations: {
            newPiece?.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        }) {_ in UIView.animate(withDuration: 0.5) {
            newPiece?.transform = CGAffineTransform.identity
            newPiece?.isUserInteractionEnabled = true
        }}
    }
    
}
