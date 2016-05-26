//
//  Types.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/26/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation

public enum TypeError : ErrorType {
    case WrongType
}

public func cast<T>(value: AnyObject) throws -> T {
    if let obj = value as? T {
        return obj
    } else {
        throw TypeError.WrongType
    }
}