//
//  FirstViewController.swift
//  Breakout_Daniel_Bram
//
//  Created by Student on 05-06-15.
//  Copyright (c) 2015 HAN. All rights reserved.
//

import UIKit
@IBDesignable
class BreakoutGameViewController: UIViewController, UICollisionBehaviorDelegate{
    
    @IBOutlet weak var gameView: UIView!
    var brickAmount: Int = 9
    let brickDiameter: Int = 30
    let paddleHeight: Int = 30
    let paddleWidth: Int = 120
    var paddle: Paddle = Paddle(frame: CGRect(x:0, y:0, width:0, height:0)){
        didSet{
            paddle.addGestureRecognizer(UIPanGestureRecognizer(target:self, action: "movePaddle:"))
        }
    }
//    var ball: Ball = Ball(frame:CGRect(x:0,y:0,width:0,height:0))
//    var paddle: UIView!
    var items: [UIView] = []
    var balls: [UIView] = []
    var blocks: [UIView] = []
    @IBOutlet weak var brickField: UIView!
    @IBOutlet weak var paddleField: UIView!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addPaddle()
        addBall()
        addBricks()
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: balls)
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: items)
        collision.collisionDelegate = self

        showAlert("\(paddle.frame.width)", message: "\(paddle.frame.height)")
        collision.addBoundaryWithIdentifier("paddle", forPath: UIBezierPath(rect: paddle.bounds))

//        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator.addBehavior(collision)
        
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
            blocks.append(brick)
            items.append(brick)
            brickXPosition = brickXPosition + brickDiameter + spaceBetweenBricks
        }
    }
    
    func addPaddle(){
        let paddleY = Int(paddleField.bounds.height) - paddleHeight
        let paddleX = Int(self.view.bounds.width/2) - paddleWidth/2
        paddle = Paddle(frame: CGRect(x: paddleX, y: paddleY, width: 130, height: paddleHeight))
        paddleField.addSubview(paddle)
//        paddle.setNeedsDisplay()
//        items.append(paddle)
//        paddle = UIView(frame: CGRect(x: 0, y: 300, width: 130, height: 20))
//        paddle.backgroundColor = UIColor.redColor()
//        view.addSubview(paddle)
    }
    
    func addBall(){
        let ballX = Int(paddle.center.x)
        let ballY = 0
        let ball = Ball(frame: CGRect(x:ballX, y: ballY, width : 20, height: 20))
        gameView.addSubview(ball)
        ball.setNeedsDisplay()
        balls.append(ball)
        items.append(ball)
//        UIView.animateWithDuration(1.0, animations: {
//            ball.frame = CGRect(x: 0, y:200, width: 20, height: 20)
//        })
    }
    
//    func addCollision(){
//        var collision = UICollisionBehavior(items: items)
//        
//    }
    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
        if let collidingView = item as? Brick{
//        showAlert("title" , message: "\(identifier)")
//            UIView.animateWithDuration(1.5, animations: {
//                collidingView.alpha = 1.0
//            })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func movePaddle(sender: UIPanGestureRecognizer) {
        switch sender.state{
        case .Ended:
            fallthrough
        case .Changed:
            let translation = sender.translationInView(self.view)
            if let view = sender.view{
                view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y)
            }
            sender.setTranslation(CGPointZero, inView: self.view)
        default:
            break
        }
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