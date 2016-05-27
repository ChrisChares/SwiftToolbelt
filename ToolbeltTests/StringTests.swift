//
//  StringTests.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/27/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import XCTest
import Nimble
@testable import Toolbelt

class StringTests: XCTestCase {
    
    func testIntValue() {
        let string = "42"
        expect(string.intValue!).to(equal(42))
    }
    
    func testContains() {
        let string = "Make America Great Again"
        
        expect(string.contains("America")).to(beTruthy())
        expect(string.contains("america")).to(beFalsy())
    }
    
    func testSubscript() {
        let string = "We're gonna build a wall"
        
        expect(string[0]).to(equal("W"))
        expect(string[6]).to(equal("g"))
        expect(string[0..<5]).to(equal("We're"))
    }
    
    func testLength() {
        expect("12345".length).to(equal(5))
    }
    
    func testLastCharacter() {
        expect("".lastCharacter).to(beNil())
        expect("12345".lastCharacter).to(equal("5"))
    }
    
    func testInsert() {
        var string = "abc"
        string.insert("5", index: 3)
        string.insert("0", index: 0)
        expect(string).to(equal("0abc5"))
    }
}
