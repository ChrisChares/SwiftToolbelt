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
    case Nil
}

public func cast<T>(value: AnyObject) throws -> T {
    guard let obj = value as? T else { throw TypeError.WrongType }
    return obj
}

public func unpack<T>(value: AnyObject?) throws -> T {
    guard let obj = value else { throw TypeError.Nil }
    return try cast(obj) as T
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