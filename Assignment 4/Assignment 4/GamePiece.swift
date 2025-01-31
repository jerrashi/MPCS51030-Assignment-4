//
//  GamePiece.swift
//  Assignment 4
//
//  Created by Jerry Shi on 1/31/25.
//

import UIKit

class GamePiece: UILabel, UIGestureRecognizerDelegate {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpGestureRecognizer()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Pan Gesture Handling
    func setUpGestureRecognizer(){
        // Double check isUserInteractionEnabled
        isUserInteractionEnabled = true
        
        // Create pan gesture
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        
        panGesture.delegate = self
        
        self.addGestureRecognizer(panGesture)
    }
    
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer){
        // We need co-ordinates relative to the view controller, not the label
        let translation = gestureRecognizer.translation(in: self.superview)
        if let view = gestureRecognizer.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            // Set Translation to zero so we don't keep increasing offset between view and actual location of finger
            gestureRecognizer.setTranslation(CGPoint.zero, in: self.superview)
        }
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
