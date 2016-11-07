//
//  NSDate.swift
//  Toolbelt
//
//  Created by Chris Chares on 10/6/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation

extension Date {
    public func isBefore(_ other: Date, slop: TimeInterval = 0) -> Bool {
        return timeIntervalSince(other) < slop
    }
    
    public func isAfter(_ other: Date, slop: TimeInterval = 0) -> Bool {
        return timeIntervalSince(other) > slop
    }
}
