//
//  ViewController.swift
//  ForceTouchDemo
//
//  Created by Adrian Kwiatkowski on 20/12/2018.
//  Copyright © 2018 Adrian Kwiatkowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var pushLabel: UIView! {
        didSet {
            pushLabel.layer.cornerRadius = 50.0
        }
    }
    
    @IBOutlet weak var strengthLabel: UILabel! {
        didSet {
            strengthLabel.text = "0.00"
        }
    }
    
    var is3DTouchAvailable: Bool {
        return view.traitCollection.forceTouchCapability == .available
        
        // for future: https://krakendev.io/force-touch-recognizers/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if ( traitCollection.forceTouchCapability == .available) {
//            registerForPreviewing(with: self as! UIViewControllerPreviewingDelegate, sourceView: view)
            strengthLabel.text = "Push the button!"
        } else {
            strengthLabel.text = "Force touch is not available \non this device."
        }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        if let touch = touches.first {
            guard is3DTouchAvailable, pushLabel.frame.contains(touch.location(in: view)) else { return }
            
            let normalizedForce = (touch.force / touch.maximumPossibleForce)
            strengthLabel.text = String(format: "%.2f", normalizedForce)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        strengthLabel.text = "0.00"
    }

}

