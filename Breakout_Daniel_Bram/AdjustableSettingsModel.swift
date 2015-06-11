//
//  AdjustableSettingsModel.swift
//  Breakout_Daniel_Bram
//
//  Created by Student on 10-06-15.
//  Copyright (c) 2015 HAN. All rights reserved.
//

import Foundation

class AdjustableSettingsModel: NSObject {
    var brickAmount: Int = 20
    var ballAmount: Int = 1
    var amountOfLives:Int = 5
    var paddleWidht: Int = 120
    
    var setBrickAmount: Int{
        get{
            return self.brickAmount
        }
        set{
            self.brickAmount = newValue
        }
    }
    
    var setBallAmount: Int{
        get{
            return self.ballAmount
        }
        set{
            self.ballAmount = newValue
        }
    }
    
    var setAmountOfLives: Int{
        get{
            return self.amountOfLives
        }
        set{
            self.amountOfLives = newValue
        }
    }
    
    var setPaddleWidht: Int{
        get{
            return self.paddleWidht
        }
        set{
            self.paddleWidht = newValue
        }
    }
}