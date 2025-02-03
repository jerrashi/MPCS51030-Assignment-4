//
//  InfoView.swift
//  Assignment 4
//
//  Created by Jerry Shi on 1/31/25.
//

import UIKit

class InfoView: UIView {
    
    override func awakeFromNib() {
        // Run original awakeFromNib code
        super.awakeFromNib()
        
       // Set rounded corners
        self.layer.cornerRadius = 20
        
        // Set a border color
        self.layer.borderColor = UIColor.gray.cgColor
        
        // Set a border width
        self.layer.borderWidth = 5
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
