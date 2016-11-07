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
//3.0 stricter?        expect { try cast(int) as Double }.toNot(throwError())
        expect { try cast(int) as String }.to(throwError(TypeError.wrongType))
    }
    
    func testUnpack() {
        let json = ["key": 23]
        expect { try unpack(json["key"]) as Int }.toNot(throwError())
        expect { try unpack(json["key"]) as String }.to(throwError())
        expect { try unpack(json["aklsjdlaksjd"]) as String }.to(throwError())
    }
}
