//
//  ViewController.swift
//  Calculator
//
//  Created by Mad Max on 05/02/15.
//  Copyright (c) 2015 HAN University of Applied Sciences. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var display: UILabel!
    
    var userIsTypingANumber = false
    var userTypedDot = false
    var shouldAddToHistory = true
    
    @IBAction func appendDigit(sender: UIButton) {
    let digit = sender.currentTitle!

        if userIsTypingANumber {
          display.text = display.text! + digit
        }else{
            display.text = digit
            userIsTypingANumber = true
        }
    }
    
    @IBAction func appendDot(sender: UIButton){
        let digit = sender.currentTitle!
        
        if userIsTypingANumber{
            if !userTypedDot{
                display.text = display.text!+digit
                userTypedDot = true
            }
        }else{
            display.text = digit
            userIsTypingANumber = true
        }
    }
    
    @IBAction func operate(sender: UIButton) {
        let operation = sender.currentTitle!
        history.text = history.text! + operation + ", "
        shouldAddToHistory = false
        if userIsTypingANumber{
            enter()
        }
        switch operation{
        case "×":performOperation { $0 * $1 }
            
        case "÷":
            if(operandStack.last != 0){ //cannot divide by 0!!
                performOperation { $1 / $0 }
            }else{
                operandStack.removeLast()
            }
        case "+":performOperation { $0 + $1 }
            
        case "−":performOperation { $1 - $0 }
            
        case "√":performOperation {sqrt($0)}
            
        case "sin":performOperation {sin($0)}
        
        case "cos": performOperation{cos($0)}
            
        case "π":
            
        if operandStack.count<1 {
                display.text = "\(M_PI)"
        }else{
                performOperation{ M_PI * $0}
            }
            
        default:break
        }
    }
    
    func performOperation(operation: (Double,Double) ->Double){
        if operandStack.count >= 2{
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast())
            enter()
        }

    }
    func performOperation(operation: Double -> Double){
        if operandStack.count >= 1{
            displayValue = operation(operandStack.removeLast())
            enter()
        }
    }
    
    @IBOutlet weak var history: UILabel!
    
    var operandStack = Array<Double>()
    var userTypedStack = Array<Double>()
   
    @IBAction func enter() {
        addToHistory(display.text!)
        userIsTypingANumber = false
        userTypedDot = false
        operandStack.append(displayValue)
        println(" operandSTack = \(operandStack)")
    }
    
    func addToHistory(value : String?){
        if shouldAddToHistory{
            history.text = history.text! + display.text! + ", "
        }
        shouldAddToHistory = true
    }
    
    var displayValue: Double {
        get{
            return NSNumberFormatter().numberFromString(display.text!)!.doubleValue
        }
        set{
           display.text =  "\(newValue)"
            userIsTypingANumber = false
        }
    }
    
    @IBAction func clear(sender: UIButton) {
        operandStack.removeAll(keepCapacity: false)
        history.text!.removeAll(keepCapacity: false)
        display.text = "0"
    }
    
}

