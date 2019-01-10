//
//  ForceTouchGestureRecognizer.swift
//  ForceTouchDemo
//
//  Created by Adrian Kwiatkowski Priv on 10/01/2019.
//  Copyright © 2019 Adrian Kwiatkowski. All rights reserved.
//

import UIKit.UIGestureRecognizerSubclass

final class ForceTouchGestureRecognizer: UIGestureRecognizer {
    
    private var trackedTouch: UITouch? = nil
    var force: CGFloat? = nil
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if touches.count != 1 {
            state = .failed
        }
        
        if trackedTouch == nil, let firstTouch = touches.first {
            trackedTouch = firstTouch
            force = normalizedForce(trackedTouch!)
            state = .began
        } else {
            for touch in touches {
                if touch != trackedTouch {
                    ignore(touch, for: event)
                }
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesMoved(touches, with: event)
        let newTouch = touches.first
        guard newTouch == trackedTouch else { state = .failed; return }
        
        force = normalizedForce(newTouch!)
        state = .changed
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesEnded(touches, with: event)
        let newTouch = touches.first
        guard newTouch == trackedTouch else { state = .failed; return}
        
        force = normalizedForce(newTouch!)
        state = .ended
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent) {
        super.touchesCancelled(touches, with: event)
        trackedTouch = nil
        force = nil
        state = .cancelled
    }
    
    override func reset() {
        super.reset()
        trackedTouch = nil
        force = nil
    }
    
    func normalizedForce(_ touch: UITouch) -> CGFloat {
        return touch.force / touch.maximumPossibleForce
    }
}
