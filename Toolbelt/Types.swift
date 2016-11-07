//
//  Types.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/26/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation

public typealias JSON = [String: Any]

public enum TypeError : Error {
    case wrongType
    case `nil`
}

public func cast<T>(_ value: Any) throws -> T {
    guard let obj = value as? T else { throw TypeError.wrongType }
    return obj
}

public func unpack<T>(_ value: Any?) throws -> T {
    guard let obj = value else { throw TypeError.nil }
    return try cast(obj) as T
}

public extension Sequence {
    public func castAll<E>() -> [E] {
        var result: [E] = []
        for obj in self {
            result.append(obj as! E)
        }
        return result
    }
}
