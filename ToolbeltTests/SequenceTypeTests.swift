//
//  SequenceTypeTests.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/27/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import XCTest
import Nimble
@testable import Toolbelt

class SequenceTypeTests: XCTestCase {
    
    func testPluck() {
        
        struct Sample {
            let value: Int
        }
        
        let array = [Sample(value:1), Sample(value:2)]
        let plucked = array.pluck { $0.value }
        expect(plucked).to(contain(1,2))
    }
    
    func testSortByProperty() {
        
        struct Sample {
            let value: Int
        }
        
        let array = [Sample(value:2), Sample(value:1)]
        let sorted = array.sortByProperty{ $0.value }
        
        expect(sorted[0].value).to(equal(array[1].value))
        expect(sorted[1].value).to(equal(array[0].value))
    }
}
