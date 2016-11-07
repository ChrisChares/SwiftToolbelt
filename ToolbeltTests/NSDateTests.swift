//
//  NSDateTests.swift
//  Toolbelt
//
//  Created by Chris Chares on 10/6/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import XCTest
import Nimble
@testable import Toolbelt

class NSDateTests: XCTestCase {
    
    func testIsBefore() {
        let date = Date()
        
        let afterDate = date.addingTimeInterval(100)
        let beforeDate = date.addingTimeInterval(-100)
        
        expect(date.isBefore(afterDate)).to(beTruthy())
        expect(date.isBefore(beforeDate)).to(beFalsy())
    }
    
    func testIsAfter() {
        let date = Date()
        
        let afterDate = date.addingTimeInterval(100)
        let beforeDate = date.addingTimeInterval(-100)
        
        expect(date.isAfter(afterDate)).to(beFalsy())
        expect(date.isAfter(beforeDate)).to(beTruthy())
    }
}
