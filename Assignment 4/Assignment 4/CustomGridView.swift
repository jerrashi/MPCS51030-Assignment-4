//
//  CustomGridView.swift
//  Assignment 4
//
//  Created by Jerry Shi on 1/30/25.
//

import UIKit

class CustomGridView: UIView {
    /// Please only use with square shaped views for best results

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        // Get CGRect dimensions
        let height = rect.height
        let width = rect.width
        
        // Check view size
        if height != width{
            print("ERROR: please only use GridView with views of equal height & width")
        }
        
        // Create a UIBezierPath
        let path = UIBezierPath()
        
        // Draw vertical lines
        for i in 1..<3 {
            // Set path starting point
            let x = width / 3 * CGFloat(i)
            path.move(to: CGPoint(x: x, y: 0))
            // Set a line to end point
            path.addLine(to: CGPoint(x: x, y: height))
        }
        
        // Draw horizontal lines
        for i in 1..<3 {
            // Set path starting point
            let y = height / 3 * CGFloat(i)
            path.move(to: CGPoint(x: 0, y: y))
            // Set a line to end point
            path.addLine(to: CGPoint(x: width, y: y))
        }
        
        
        // Set the color
        UIColor.purple.setStroke()
        // Set the width
        path.lineWidth = 6.0
        // Draw the line
        path.stroke()
    }

}
