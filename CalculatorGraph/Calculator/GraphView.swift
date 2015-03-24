//
//  GraphView.swift
//  Calculator
//
//  Created by Mad Max on 20/03/15.
//  Copyright (c) 2015 HAN University of Applied Sciences. All rights reserved.
//

import UIKit

//protocol GraphViewDataSource: class{
//    func dataForGraphView(sender:GraphView) -> Double?
//}
class GraphView: UIView {

    var axesDrawer = AxesDrawer()
    var scale: CGFloat = 50 {didSet {setNeedsDisplay() } }
    var graphCenter: CGPoint = CGPoint(){
        didSet{
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        
        graphCenter = center
        println(" setting center" )
        axesDrawer.drawAxesInRect(rect, origin:graphCenter, pointsPerUnit: scale)
    }
    
    func moveGraph(sender: UIPanGestureRecognizer) {
        switch sender.state{
        case .Ended:
            fallthrough
        case .Changed:
            println("moving")
            let translation = sender.translationInView(self)
            graphCenter.x += translation.x
            graphCenter.y += translation.y
            sender.setTranslation(CGPointZero, inView:self)
        default:
            break
        }
    }
    
    func scale(gesture: UIPinchGestureRecognizer){
        if gesture.state == .Changed{
            scale *= gesture.scale
            gesture.scale = 1
        }
    }

}
