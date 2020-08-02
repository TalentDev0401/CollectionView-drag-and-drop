//
//  Timer+Extensions.swift
//
//  Created by Kirill Chistyakov on 29.01.2020.
//  Copyright © 2020 Kirill Chistyakov. All rights reserved.
//

import Foundation

extension Timer {
    
    @discardableResult
    class func schedule(delay: TimeInterval, handler: @escaping (CFRunLoopTimer?) -> Void) -> Timer {
        let fireDate = delay + CFAbsoluteTimeGetCurrent()
        let timer = CFRunLoopTimerCreateWithHandler(kCFAllocatorDefault, fireDate, 0, 0, 0, handler)
        CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, CFRunLoopMode.commonModes)
        return timer!
    }
    
}
