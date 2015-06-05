//
//  FirstViewController.swift
//  Breakout_Daniel_Bram
//
//  Created by Student on 05-06-15.
//  Copyright (c) 2015 HAN. All rights reserved.
//

import UIKit
@IBDesignable
class BreakoutGameViewController: UIViewController {

    @IBOutlet weak var gameView: UIView!
    var brickAmount: Int = 50
    let brickDiameter: Int = 30
    let paddleHeight: Int = 30
    let paddleWidth: Int = 120
    var paddle: Paddle = Paddle(frame: CGRect(x:0, y:0, width:0, height:0)){
        didSet{
            paddle.addGestureRecognizer(UIPanGestureRecognizer(target:paddle, action: "movePaddle:"))
        }
    }
    
    @IBOutlet weak var brickField: UIView!
    @IBOutlet weak var paddleField: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        addBricks()
        addPaddle()
    }
    
    func addBricks(){
        var maxBricksPerRow = Int(self.view.frame.width) / (brickDiameter+10)
        //Cannot put equal bricks on each row
        
        var brickXPosition = 0
        var brickYPosition = 0
        let spaceBetweenBricks = 5
        let maxRows = brickAmount / maxBricksPerRow
        var currentRow = 0
        
        for var i = 0; i < brickAmount; i++ {
            if i % maxBricksPerRow == 0 && i != 0{
                brickYPosition += brickDiameter + spaceBetweenBricks*2
                brickXPosition = 0
            }
            
            var brick = Brick(frame: CGRect(x: brickXPosition, y: brickYPosition, width: brickDiameter, height: brickDiameter))
            brickField.addSubview(brick)
            brick.setNeedsDisplay()
            brickXPosition = brickXPosition + brickDiameter + spaceBetweenBricks

        }
    }
    
    func addPaddle(){
        let paddleY = Int(paddleField.bounds.height) - paddleHeight
        let paddleX = Int(self.view.bounds.width/2) - paddleWidth/2
        
        paddle = Paddle(frame: CGRect(x: paddleX, y: paddleY, width: paddleWidth, height: paddleHeight))
        paddleField.addSubview(paddle)
        paddle.setNeedsDisplay()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert(title: String, message:String){
        
                    var alert = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Working!!", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
}

//            var alert = UIAlertController(title: " Title" , message: "\(brickXPosition)", preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: "Working!!", style: UIAlertActionStyle.Default, handler: nil))
//self.presentViewController(alert, animated: true, completion: nil)
//