//
//  Ball.swift
//  Breakout_Daniel_Bram
//
//  Created by Student on 05-06-15.
//  Copyright (c) 2015 HAN. All rights reserved.
//

import UIKit

class Ball: UIView, UICollisionBehaviorDelegate {
    override func drawRect(rect: CGRect) {
        var path = UIBezierPath(ovalInRect: rect)
        UIColor.cyanColor().setFill()
        path.fill()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = UIColor.clearColor()
    }
    
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        if let collidingView = item as?  UIView{
//            showAlert("title" , message: "\(identifier)")
            UIView.animateWithDuration(1.5, animations: {
                collidingView.alpha = 1.0
            })
        }
    }
}

