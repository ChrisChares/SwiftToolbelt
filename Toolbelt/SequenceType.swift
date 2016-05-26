//
//  SequenceType.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/26/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

extension SequenceType {
    func find(fn: (Generator.Element) -> Bool) -> Generator.Element? {
        for element in self {
            if fn(element) {
                return element
            }
        }
        return nil
    }
    
    func divide(fn: (Generator.Element) -> Bool) -> (slice: [Generator.Element], remainder: [Generator.Element]) {
        var slice : [Generator.Element] = []
        var remainder: [Generator.Element] = []
        
        for item in self {
            if fn(item) {
                slice.append(item)
            } else {
                remainder.append(item)
            }
        }
        return (slice: slice, remainder: remainder)
    }
    
    
    func groupBy<T: Hashable>(fn: (Generator.Element) -> T) -> [T: [Generator.Element]] {
        var dictionary: [T: [Generator.Element]] = [:]
        
        for item in self {
            let grouper = fn(item)
            if var array = dictionary[grouper] {
                array.append(item)
                dictionary[grouper] = array
            } else {
                dictionary[grouper] = [item]
            }
        }
        return dictionary
    }
    
    func filterByType<T>() -> [T] {
        return filter { $0 is T } .map { $0 as! T }
    }
}
