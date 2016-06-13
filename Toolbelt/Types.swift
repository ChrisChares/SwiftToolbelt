//
//  Types.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/26/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation

public typealias JSON = [String: AnyObject]

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

public extension SequenceType {
    public func castAll<E>() -> [E] {
        var result: [E] = []
        for obj in self {
            result.append(obj as! E)
        }
        return result
    }
}