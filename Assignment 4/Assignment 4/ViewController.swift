//
//  ViewController.swift
//  Assignment 4
//
//  Created by Jerry Shi on 1/30/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Get screen dimensions
        // iphone 15 pro size: 852 x 393
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
        
        // Add a GridView subview
        let gridView = GridView(frame: CGRect(x: 0, y: 100, width: screenWidth, height: screenWidth))
        gridView.backgroundColor = .white
        view.addSubview(gridView)
    }
}
