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
    var paddle: UIView! {
        didSet{
            paddle.addGestureRecognizer(UIPanGestureRecognizer(target:self, action: "movePaddle:"))
        }
    }
    
    //    var ball: Ball = Ball(frame:CGRect(x:0,y:0,width:0,height:0))
    //    var paddle: UIView!
    var items: [UIView] = []
    var balls: [UIView] = []
    var blocks: [UIView] = []
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var collision: UICollisionBehavior!
    var bounceFactor : UIDynamicItemBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        addPaddle()
        addBricks()
        addBall()
        
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        animator = UIDynamicAnimator(referenceView: view)
        gravity = UIGravityBehavior(items: balls)
        animator.addBehavior(gravity)
        
        bounceFactor = UIDynamicItemBehavior(items: balls)
        bounceFactor.elasticity = 1.0
        animator.addBehavior(bounceFactor)
        
        var brickBehaviour = UIDynamicItemBehavior(items: blocks)
        brickBehaviour.resistance = CGFloat.max
        brickBehaviour.allowsRotation = false
        brickBehaviour.density = 0
        animator.addBehavior(brickBehaviour)
        
        collision = UICollisionBehavior(items: items)
        collision.translatesReferenceBoundsIntoBoundary = true
        collision.collisionDelegate = self
        
        //        for var i = 0 ; i < brickAmount; i++ {
        ////            collision.addBoundaryWithIdentifier("bricks"+"\(i)", forPath: UIBezierPath(rect: blocks[i].frame ))
        //        }
        
        //        showAlert("\(paddle.frame.width)", message: "\(paddle.frame.height)")
        collision.addBoundaryWithIdentifier("paddle", forPath: UIBezierPath(ovalInRect: paddle.frame))
        collision.collisionMode = UICollisionBehaviorMode.Everything
        
        
        animator.addBehavior(collision)
        
    }
    
    func addBricks(){
        var maxBricksPerRow = Int(self.view.frame.width) / (brickDiameter+10)
        //Cannot put equal bricks on each row
        
        var brickXPosition = 0 + 20
        var brickYPosition = 50 + 20
        let spaceBetweenBricks = 5
        let maxRows = brickAmount / maxBricksPerRow
        var currentRow = 0
        
        for var i = 0; i < brickAmount; i++ {
            if i % maxBricksPerRow == 0 && i != 0{
                brickYPosition += brickDiameter + spaceBetweenBricks*2
                brickXPosition = 0
            }
            
            var brick = Brick(frame: CGRect(x: brickXPosition, y: brickYPosition, width: brickDiameter, height: brickDiameter))
            gameView.addSubview(brick)
            brick.setNeedsDisplay()
            blocks.append(brick)
            items.append(brick)
            brickXPosition = brickXPosition + brickDiameter + spaceBetweenBricks
        }
    }
    
    func addPaddle(){
        let tabbaerHeight = Int(gameView.frame.height)
        
        let paddleY = Int(gameView.frame.height) - Int(tabBarController!.tabBar.frame.height) - paddleHeight
        let paddleX = Int(gameView.frame.width/2) - paddleWidth/2
        paddle = UIView(frame: CGRect(x: paddleX, y: paddleY, width: 130, height: paddleHeight))
        paddle.backgroundColor = UIColor.redColor()
        gameView.addSubview(paddle)
        
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
    //    func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
    //        if identifier as! String == "paddle" {
    //            if let collidingView = item as? UIView{
    //            showAlert("ITS A " , message: "Paddle")
    //            UIView.animateWithDuration(1.5, animations: {
    ////                    collidingView.alpha = 0.0
    //                })
    //            }
    //        }
    //
    //        for var i = 0 ; i < brickAmount; i++ {
    //            if identifier as! String == "brick"+"\(i)" {
    //            }
    //        }
    //        //        if let collidingView = item as?  UIView{
    ////        showAlert("title" , message: "\(identifier)")
    ////            UIView.animateWithDuration(1.5, animations: {
    ////                collidingView.alpha = 1.0
    ////            })
    ////        }
    //    }
    func collisionBehavior(behavior: UICollisionBehavior, endedContactForItem item1: UIDynamicItem, withItem item2: UIDynamicItem){
        if let brick  = item2 as? Brick{
            UIView.animateWithDuration(0.5, animations: {
                brick.alpha = 0.0
                self.collision.removeItem(brick)
                }, completion:{ finished in
                    brick.removeFromSuperview()
                    
            })
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
            collision.removeBoundaryWithIdentifier("paddle")
            collision.addBoundaryWithIdentifier("paddle", forPath: UIBezierPath(ovalInRect: paddle.frame))
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