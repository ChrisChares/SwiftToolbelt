//
//  GCD.swift
//  HuntFish
//
//  Created by Chris Chares on 2/1/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

public struct GCD {
    //: In seconds
    public static func dispatchAfter(seconds delay: Double, fn:@escaping () -> Void) {
        
        let delayInNanoSeconds = DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
        let mainQueue = DispatchQueue.main
        
        mainQueue.asyncAfter(deadline: delayInNanoSeconds, execute: fn)
    }
    
    public static func dispatchBackground(_ fn: @escaping () -> Void) {
        let queue = DispatchQueue.global(priority: DispatchQueue.GlobalQueuePriority.background)
        queue.async(execute: fn)
    }
    
    public static func dispatchMain(_ fn: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.async(execute: fn)
    }
}
