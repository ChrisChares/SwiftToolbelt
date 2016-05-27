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
    
    class Sample {
        let value: Int
        init(value: Int) {
            self.value = value
        }
    }
    
    func testPluck() {
        let array = [Sample(value:1), Sample(value:2)]
        let plucked = array.pluck { $0.value }
        
        expect(plucked).to(contain(1,2))
    }
    
    func testSortByProperty() {
        let array = [Sample(value:2), Sample(value:1)]
        let sorted = array.sortByProperty{ $0.value }
        
        expect(sorted[0]).to(beIdenticalTo(array[1]))
        expect(sorted[1]).to(beIdenticalTo(array[0]))
    }
    
    func testFind() {
        let array = [Sample(value:1), Sample(value:2), Sample(value:3)]
        let found = array.find { $0.value == 2 }
        
        expect(found).toNot(beNil())
        expect(found).to(beIdenticalTo(array[1]))
        
        let notFound = array.find { $0.value == 1337 }
        expect(notFound).to(beNil())
    }
    
    func testFilterByType() {
        let array = [1,2,"Rick","Morty"]
        let integers = array.filterByType() as [Int]
        let strings = array.filterByType() as [String]
        
        expect(integers.count).to(equal(2))
        expect(strings.count).to(equal(2))
        expect(integers).to(contain(1,2))
        expect(strings).to(contain("Rick","Morty"))
    }
}
