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
    var graphCenter: CGPoint{
        get{
            return convertPoint(center, fromView:superview)
        }
        set{
            setNeedsDisplay()
        }
    }
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        axesDrawer.drawAxesInRect(rect, origin:graphCenter, pointsPerUnit: scale)
    }
    

}
