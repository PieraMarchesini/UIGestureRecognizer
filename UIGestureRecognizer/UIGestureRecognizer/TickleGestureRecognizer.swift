//
//  TickleGestureRecognizer.swift
//  UIGestureRecognizer
//
//  Created by Piera Marchesini on 17/04/17.
//  Copyright © 2017 Piera Marchesini. All rights reserved.
//

import UIKit

class TickleGestureRecognizer: UIGestureRecognizer {
    
    //These are the constants that define what the gesture will need. Note that requiredTickles will be inferred as an Int, but you need to specify distanceForTickleGesture as a CGFloat. If you do not, then it will be inferred as a Double, and cause difficulties when doing calculations with CGPoints later on
    let requiredTickles = 2
    let distanceForTickleGesture:CGFloat = 25.0
    
    //These are the possible tickle directions
    enum Direction:Int {
        case DirectionUnknown = 0
        case DirectionLeft
        case DirectionRight
    }
    
    //Variables to keep track of to detect this gesture
    //How many times the user has switched the direction of their finger (while moving a minimum amount of points). Once the user moves their finger direction three times, you count it as a tickle gesture
    var tickleCount:Int = 0
    //The point where the user started moving in this tickle. You’ll update this each time the user switches direction (while moving a minimum amount of points)
    var curTickleStart:CGPoint = CGPoint.zero
    //The last direction the finger was moving. It will start out as unknown, and after the user moves a minimum amount you’ll check whether they’ve gone left or right and update this appropriately
    var lastDirection:Direction = .DirectionUnknown
    
    
}
