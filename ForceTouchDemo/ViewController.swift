//
//  ViewController.swift
//  ForceTouchDemo
//
//  Created by Adrian Kwiatkowski on 20/12/2018.
//  Copyright © 2018 Adrian Kwiatkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var is3DTouchAvailable: Bool {
        return view.traitCollection.forceTouchCapability == .available
    }
    
    @IBOutlet weak var buttonView: UIView! {
        didSet {
            buttonView.layer.cornerRadius = 100.0
            buttonView.backgroundColor = UIColor.green
        }
    }
    
    @IBOutlet weak var strengthLabel: UILabel! {
        didSet {
            strengthLabel.text = "0.00"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if is3DTouchAvailable {
            strengthLabel.text = "Push the button!"
            let forceTouchGestureRecognizer = ForceTouchGestureRecognizer(target: self, action: #selector(handleForceTouch(_:)))
            buttonView.addGestureRecognizer(forceTouchGestureRecognizer)
        } else {
            strengthLabel.text = "Force touch is not available \non this device."
        }
    }
    
    @objc func handleForceTouch(_ recognizer: ForceTouchGestureRecognizer) {
        if let force = recognizer.force {
            strengthLabel.text = String(format: "%.2f", force)
            
            buttonView.backgroundColor = UIColor(red: force * 2, green: (1.0 - force) * 2, blue: 0.0, alpha: 1.0)
        }
    }
}

