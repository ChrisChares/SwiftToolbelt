//
//  GCD.swift
//  HuntFish
//
//  Created by Chris Chares on 2/1/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

struct GCD {
    //: In seconds
    static func dispatchAfter(seconds delay: Double, fn:() -> Void) {
        
        let delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, Int64(delay * Double(NSEC_PER_SEC)))
        let mainQueue = dispatch_get_main_queue()
        
        dispatch_after(delayInNanoSeconds, mainQueue, fn)
    }
    
    static func dispatchAsync(fn: () -> Void) {
        let queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
        dispatch_async(queue, fn)
    }
}