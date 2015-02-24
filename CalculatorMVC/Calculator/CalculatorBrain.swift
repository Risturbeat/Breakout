//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Mad Max on 12/02/15.
//  Copyright (c) 2015 HAN University of Applied Sciences. All rights reserved.
//

import Foundation


class CalculatorBrain{
    
    enum Op : Printable{
        case Operand (Double)
        case UnaryOperation (String, Double-> Double)
        case BinaryOperation (String, (Double,Double) -> Double)
        
        var description: String {
            get{
                switch self{
                case .Operand(let operand):
                    return "\(operand)"
                case .UnaryOperation(let symbol, _):
                    return symbol
                case .BinaryOperation(let symbol, _):
                    return symbol
                }
            }
        }
    }
    
    private var opStack = [Op]()
    private var currentOpStack = [Op]()
    private var knownOps = [String:Op]()
    private var variableValues = [String:Double]()
    
    init(){
        func learnop (op:Op){
            knownOps[op.description]=op
        }
        knownOps["×"] = Op.BinaryOperation("×", *)
        knownOps["÷"] = Op.BinaryOperation("÷") {$1 / $0}
        knownOps["+"] = Op.BinaryOperation("+", +)
        knownOps["-"] = Op.BinaryOperation("-") {$1 - $0}
        knownOps["√"] = Op.UnaryOperation("√", sqrt)
        
    }
    
    func pushOperand( operand: Double)->Double?{
        opStack.append(Op.Operand(operand))
        return evaluate()
    }
    
    func pushOperand(symbol: String) ->Double?{
        return evaluate()
    }
    
    func getCurrentOpStack() ->[Op]{
        println("The current op stack is:  " + "\(opStack)")
        return currentOpStack
    }
    
    private func evaluate(ops: [Op]) -> (result: Double?, remainingOps: [Op]){
        if !ops.isEmpty{
            var remainingOps = ops
            let op = remainingOps.removeLast()
            switch op{
            case .Operand(let operand):
                return(operand, remainingOps)
            case .UnaryOperation(_, let operation):
                let operandEvaluation = evaluate(remainingOps)
                if let operand = operandEvaluation.result{
                    return (operation(operand),operandEvaluation.remainingOps)
                }
            case .BinaryOperation (_, let operation):
                let op1Evaluation = evaluate(remainingOps)
                if let operand1 = op1Evaluation.result{
                    let op2Evaluation = evaluate(op1Evaluation.remainingOps)
                    if let operand2 = op2Evaluation.result{
                        return (operation(operand1, operand2), op2Evaluation.remainingOps)
                    }
                }
            }
            if !remainingOps.isEmpty{
                opStack = remainingOps
            }
        }
        return (nil, ops)
    }
    
    func evaluate() -> Double?{
        let(result, remainder) = evaluate(opStack)
        println("\(opStack) = \(result) with \(remainder) left over")
        return result
    }
    
    
    func performOperation(symbol: String)-> Double?{
        if let operation = knownOps[symbol]{
            opStack.append(operation)
        }
        
        return evaluate()
    }

}