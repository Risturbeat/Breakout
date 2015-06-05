//
//  Paddle.swift
//  Breakout_Daniel_Bram
//
//  Created by Student on 05-06-15.
//  Copyright (c) 2015 HAN. All rights reserved.
//

import UIKit

class Paddle: UIView{
    
    var paddleCenter : CGPoint = CGPoint(){
        didSet{
            setPaddleCenterToCenter = false
            setNeedsDisplay()
        }
    }
    var setPaddleCenterToCenter : Bool = true { didSet { if setPaddleCenterToCenter{ setNeedsDisplay() } } }
    
    override func drawRect(rect: CGRect) {
        if setPaddleCenterToCenter{
            paddleCenter = center
        }
        
        var path = UIBezierPath(rect:rect)
        UIColor.redColor().setFill()
        path.fill()
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func movePaddle(sender: UIPanGestureRecognizer) {
        
        switch sender.state{
        case .Ended:
            fallthrough
        case .Changed:
            let translation = sender.translationInView(self)
            paddleCenter.x += translation.x
            paddleCenter.y += translation.y
            sender.setTranslation(CGPointZero, inView:self)
        default:
            break
        }
    }
}