//
//  Utility.swift
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import UIKit

func +(left: CGPoint?, right: CGPoint?) -> CGPoint? {
    guard left != nil && right != nil else { return nil }
    return CGPoint(x: left!.x + right!.x, y: left!.y + right!.y)
}

// Based on Arduino's map(), https://www.arduino.cc/en/reference/map
func mapValue(_ value: CGFloat, inMin: CGFloat, inMax: CGFloat, outMin: CGFloat, outMax: CGFloat) -> CGFloat {
    return (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin
}

func ==(left: (direction: StackedFlowLayout.AutoScrollDirection, magnitude: CGFloat)?, right: (direction: StackedFlowLayout.AutoScrollDirection, magnitude: CGFloat)?) -> Bool {
    return left?.direction == right?.direction && left?.magnitude == right?.magnitude
}
