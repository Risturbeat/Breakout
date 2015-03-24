//
//  GraphViewController.swift
//  Calculator
//
//  Created by Mad Max on 20/03/15.
//  Copyright (c) 2015 HAN University of Applied Sciences. All rights reserved.
//

import UIKit

class GraphViewController: UIViewController {
    @IBOutlet weak var graphView: GraphView!{
        didSet{
            graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: "scale:"))
            graphView.addGestureRecognizer(UIPanGestureRecognizer(target:graphView, action: "moveGraph:"))
            let tapGesture = UITapGestureRecognizer(target: graphView, action:"setGraphCenterToTappedPosition:")
            tapGesture.numberOfTapsRequired = 2
            graphView.addGestureRecognizer(tapGesture)
            
            //rshankar.com/uitgesturerecognizer-in-swift
            //graphView.addGestureRecognizer(UITapGestureRecognizer(target: graphView, action: "setGraphCenterToTappedPosition:"))
        }
    }
    func setGraphCenterToTappedPosition(gesture:UITapGestureRecognizer){
        
    }
}
