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
    @IBOutlet weak var history: UILabel!
    @IBOutlet weak var stackLabel: UILabel!
    
    var userIsTypingANumber = false
    var userTypedDot = false
    var shouldAddToHistory = true
    var operandStack = Array<Double>() //Moet weg
    var userTypedStack = Array<Double>()
    var brain = CalculatorBrain()

    
    @IBAction func appendDigit(sender: UIButton) {
        let digit = sender.currentTitle!

        if userIsTypingANumber{
            println("User is typing and appending")
            display.text = display.text! + digit
        }else{
            println("User is not typting")
            display.text = digit
            userIsTypingANumber = true
        }
    }
    
    @IBAction func appendDot(sender: UIButton){
        let digit = sender.currentTitle!
        
        if userIsTypingANumber && digit == "." && display.text!.rangeOfString(".") == nil {
                display.text = display.text! + digit
        }else{
            if !userIsTypingANumber{
                display.text = "0" + digit
                userIsTypingANumber = true
            }
           
        }
    }
    
    @IBAction func addPi(sender: UIButton) {
        if userIsTypingANumber{
            enter()
        }
            display.text = "\(M_PI)"
            enter()
        }
    
    @IBAction func operate(sender: UIButton) {
        if userIsTypingANumber{
            enter()
        }
        
        if let operation = sender.currentTitle {
            if let result = brain.performOperation(operation){
                displayValue = result
            }else{
                displayValue = 0
            }
            history.text = history.text! + operation + ", "
        }
        
        
        shouldAddToHistory = false
        
        }
    
    @IBAction func executePlusMinus(sender: UIButton) {
        var valueToDisplay = (displayValue * -1).description
        removeRange(&valueToDisplay, valueToDisplay.rangeOfString(".0")!)
        display.text = valueToDisplay
        userIsTypingANumber = true
    }
    
    func showEqualsSign(){
        if history.text!.rangeOfString("=") != nil{
            history.text!.removeRange(history.text!.rangeOfString(", =")!)
        }
        shouldAddToHistory = true
        addToHistory("=")
        
    }
    
    @IBAction func enter() {
        addToHistory(display.text!)
        
        userIsTypingANumber = false
        userTypedDot = false
        
        if let result = brain.pushOperand(displayValue){
            displayValue = result
        }else{
            displayValue = 0 //Niet netjes
        }
        
        //operandStack.append(displayValue) // moet weg
        updateStack() // moet weg
        println(" operandSTack = \(operandStack)")
    }
    
    func addToHistory(value : String){
        if shouldAddToHistory{
            switch value{
                case "\(M_PI)": history.text = history.text! + "3.14" + ", "
                case "=": history.text = history.text! + value + ", "
                default: history.text = history.text! + display.text! + ", "
            }
        }
        shouldAddToHistory = true
    }
    
    func updateStack(){
        stackLabel.text = "Operand stack: " + "\(operandStack)"
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
        stackLabel.text = "Operand stack:"
        display.text = "0"
    }
    
    @IBAction func backspace(sender: UIButton) {
        display.text = dropLast(display.text!)
        if countElements(display.text!) < 1 {
            display.text = "0"
            userIsTypingANumber = false
        }
    }
}

