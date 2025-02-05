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
    
    // Set up Variables
    var isXTurn = false
    var initialCenter: CGPoint = .zero
    let grid: Grid = Grid()
    var isWinOrTie = false
    
    
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
        
    }
    
    // MARK: - Gesture Metods
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer){
        var snappedToGrid = false
        if let view = gestureRecognizer.view{
            switch gestureRecognizer.state{
            case .began:
                // TODO: (Optional) Change view to snap to center of touch
                initialCenter = view.center
            case .changed:
                let translation = gestureRecognizer.translation(in: self.view)
                view.center = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
                // Note: We don't use this since we track from starting position, instead of cumulative movement
                //gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
            case .ended, .cancelled:
                for square in squares{
                    if square.frame.contains(view.center) && grid.isEmpty(square.tag) {
                        // Animate piece "snapping" into place
                        UIView.animate(withDuration: 1, animations: {
                            view.center = square.center
                        })
                        
                        // Modify square to look the same as piece
                        square.backgroundColor = isXTurn ? .blue : .red
                        square.textAlignment = .center
                        square.text = isXTurn ? "X" : "O"
                        square.font = UIFont.systemFont(ofSize: 120, weight: .bold)
                        square.textColor = UIColor.white
                        
                        // Update grid model
                        grid.update(square.tag, isXTurn ? "X" : "O")
                                                
                        // Move piece back to starting spot
                        view.center = self.initialCenter
                        
                        // Update snappedToGrid variable so we don't animate snap back twice
                        snappedToGrid = true
                        
                        // Check for winner
                        if let winner = grid.checkWin() {
                            infoViewLabel.text = "Congrulations! \(winner) has won!"
                            isWinOrTie = true
                        }
                        
                        // Check for tie
                        else if grid.checkTie() {
                            infoViewLabel.text = "It's a tie!"
                            isWinOrTie = true
                        }
                        
                        else{
                            switchTurn()
                        }
                        }
                }
                
                if snappedToGrid == false {
                    // Animate piece snapping back to starting spot
                    UIView.animate(withDuration: 0.25, animations: {
                        // Move view back to starting spot
                        view.center = self.initialCenter
                    })
                }
                
                if isWinOrTie {
                    // Make sure infoView is on top of stack
                    self.view.bringSubviewToFront(infoView)
                            
                    // Animate infoView
                    UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
                        // Move view from off screen to middle of screen vertically
                        self.infoView.frame.origin.y = self.view.center.y - self.infoView.frame.height / 2
                    })
                }
                
            default:
                break
            }
        }
        else {
            print("ERROR - gesture recognizer view not unwrapped")
        }
    }
    
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
        
        // Animate infoView to move off screen
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            // Move view from off screen to middle of screen vertically
            self.infoView.frame.origin.y = self.view.frame.height
        })
        {_ in
            // reset view to right above screen
            self.infoView.frame.origin.y = -self.infoView.frame.height
        }
        
        if isWinOrTie{
            resetGrid()
            isWinOrTie = false
        }
    }
    
    // MARK: - switchTurn Function
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
    
    // MARK: - resetGrid Function
    func resetGrid() {
        UIView.animate(withDuration: 0.5, animations: {
            // Fade out squares
            for square in self.squares {
                square.alpha = 0
            }
        }) { _ in
            // Reset squares
            for square in self.squares {
                square.text = ""
                square.alpha = 1
                square.backgroundColor = .clear
            }
        }
        self.grid.clear()
        self.isXTurn = false
        self.switchTurn()
        
    }
    
}
