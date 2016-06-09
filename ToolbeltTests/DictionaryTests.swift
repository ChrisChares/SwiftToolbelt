//
//  DictionaryTests.swift
//  Toolbelt
//
//  Created by Chris Chares on 6/9/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import XCTest
import Nimble
@testable import Toolbelt

class DictionaryTests: XCTestCase {
    
    func testMerge() {
        let first: JSON = [
            "a": "123",
            "b": "456"
        ]
        
        let second: JSON = [
            "b": 678,
            "nested": [
                "a": 123,
                "b": "123"
            ]
        ]
        
        let merged = first.merge(second)

        expect(merged["a"] as? String).to(equal("123"))
        expect(merged["b"] as? Int).to(equal(678))
        
        let nested = merged["nested"] as! JSON
        
        expect(nested["a"] as? Int).to(equal(123))
        expect(nested["b"] as? String).to(equal("123"))
    }
}
