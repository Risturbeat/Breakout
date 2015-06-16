//
//  SecondViewController.swift
//  Breakout_Daniel_Bram
//
//  Created by Student on 05-06-15.
//  Copyright (c) 2015 HAN. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    private let defaults = NSUserDefaults.standardUserDefaults()
    var settings = Settings()
  
    @IBOutlet weak var brickSlider: UISlider!
    @IBOutlet weak var lifeStepper: UIStepper!
    @IBOutlet weak var paddleSegmentedControl: UILabel!
    
    
    @IBAction func brickAmountChanged(sender: UISlider) {
        brickAmountLabel.text = "\(Int(sender.value))"
        defaults.setObject(Int(sender.value), forKey: "brickAmount")
    }
    @IBAction func lifeAmountChanged(sender: UIStepper) {
        lifeAmountLabel.text = "\(Int(sender.value))"
        defaults.setObject(Int(sender.value), forKey: "lifeAmount")
    }
    @IBAction func paddleSizeChanged(sender: UISegmentedControl) {
        var paddleWidth: Int = 0
        switch(sender.selectedSegmentIndex){
        case 0:
            paddleWidth = 80
            break;
        case 1:
            paddleWidth = 120
            break;
        case 2:
            paddleWidth = 160
            break;
        default:
            paddleWidth = 120
            break;
        }
        defaults.setObject(paddleWidth, forKey: "paddleWidth")
        paddleSizeLabel.text = "\(paddleWidth)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        brickAmountLabel.text = "\(Int(brickSlider.value))"
        lifeAmountLabel.text = "\(Int(lifeStepper.value))"
        
        var paddleSize: Int = 120
        switch (paddleSegmentedControl.text!){
            case "Small" :
                paddleSize = 80
                break;
            case "Middle" :
                paddleSize = 120
                break;
            case "Big" :
                paddleSize = 160
                break;
        default:
            break;
        }
        paddleSizeLabel.text = "\(paddleSize)"
        
        defaults.setObject(Int(brickSlider.value), forKey: "brickAmount")
        defaults.setObject(Int(lifeStepper.value), forKey: "lifeAmount")
        defaults.setObject(paddleSize, forKey: "paddleWidth")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }


    @IBOutlet weak var brickAmountLabel: UILabel!
    @IBOutlet weak var lifeAmountLabel: UILabel!
    @IBOutlet weak var paddleSizeLabel: UILabel!
}

