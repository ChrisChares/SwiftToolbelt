//
//  SequenceType.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/26/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

public extension SequenceType {
    /*:
        Returns the first object the passed function returns true for
    */
    public func find(fn: (Generator.Element) -> Bool) -> Generator.Element? {
        for element in self {
            if fn(element) {
                return element
            }
        }
        return nil
    }
    
    public func divide(fn: (Generator.Element) -> Bool) -> (slice: [Generator.Element], remainder: [Generator.Element]) {
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
    
    
    public func groupBy<T: Hashable>(fn: (Generator.Element) -> T) -> [T: [Generator.Element]] {
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
    
    public func chunk(size: Int) -> [[Generator.Element]] {
        var i = 0
        var result :[[Generator.Element]] = []
        
        var xs : [Generator.Element] = []
        for item in self {
            xs.append(item)
            if i % size == 0 && i != 0 {
                result.append(xs)
                xs = []
            }
            i += 1
        }
        return result
    }
    
    public func filterByType<T>() -> [T] {
        return filter { $0 is T } .map { $0 as! T }
    }
    /*
     Sort by a chosen property
     */
    public func sortByProperty<T: Comparable>(ascending: Bool = true, fn: (Generator.Element) -> T) -> [Generator.Element] {
        
        return sort {
            let a = fn($0)
            let b = fn($1)
            
            if ascending {
                return a < b
            } else {
                return a > b
            }
        }
    }
    /*:
     Create a new array by plucking a value from each object in the existing array
     */
    public func pluck<T>(fn: (Generator.Element) -> T) -> [T] {
        return map { fn($0) }
    }
    
    public func filterMax<E: protocol<Comparable, Hashable>>(fn:(Generator.Element) -> E?) -> [Generator.Element] {
        
        var maximums: [Generator.Element] = []
        var max: E? = nil
        
        for obj in self {
            guard let value = fn(obj) else  {
                continue
            }
            
            guard let previousMax = max else {
                max = value
                if max != nil {
                    maximums.append(obj)
                }
                continue
            }
            
            if value > previousMax {
                maximums.removeAll()
                maximums.append(obj)
                max = value
            } else if value == previousMax {
                maximums.append(obj)
            }
        }
        return maximums
    }
    
    /*:
        Return the first `count` objects from a sequence
    */
    public func first(count: Int) -> [Generator.Element] {
        var result: [Generator.Element] = []
        var i = 0
        for obj in self {
            if i > count {
                break
            }
            result.append(obj)
            i += 1
        }
        return result
    }
}
