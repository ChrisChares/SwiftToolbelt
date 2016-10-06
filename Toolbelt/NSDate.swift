//
//  NSDate.swift
//  Toolbelt
//
//  Created by Chris Chares on 10/6/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation

extension NSDate {
    func isBefore(other: NSDate, slop: NSTimeInterval = 0) -> Bool {
        return timeIntervalSinceDate(other) < slop
    }
    
    func isAfter(other: NSDate, slop: NSTimeInterval = 0) -> Bool {
        return timeIntervalSinceDate(other) > slop
    }
}
