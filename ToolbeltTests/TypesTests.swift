//
//  TypesTests.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/27/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import XCTest
import Nimble
@testable import Toolbelt

class TypesTests: XCTestCase {
    
    func testCast() {
        let int = 42
        expect { try cast(int) as Double }.toNot(throwError())
        expect { try cast(int) as String }.to(throwError(TypeError.WrongType))
    }
}
