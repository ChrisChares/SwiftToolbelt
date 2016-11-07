//
//  SequenceType.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/26/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

public extension Sequence {
    /*:
        Returns the first object the passed function returns true for
    */
    public func find(_ fn: (Iterator.Element) -> Bool) -> Iterator.Element? {
        for element in self {
            if fn(element) {
                return element
            }
        }
        return nil
    }
    
    public func divide(_ fn: (Iterator.Element) -> Bool) -> (slice: [Iterator.Element], remainder: [Iterator.Element]) {
        var slice : [Iterator.Element] = []
        var remainder: [Iterator.Element] = []
        
        for item in self {
            if fn(item) {
                slice.append(item)
            } else {
                remainder.append(item)
            }
        }
        return (slice: slice, remainder: remainder)
    }
    
    
    public func groupBy<T: Hashable>(_ fn: (Iterator.Element) -> T) -> [T: [Iterator.Element]] {
        var dictionary: [T: [Iterator.Element]] = [:]
        
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
    
    public func chunk(_ size: Int) -> [[Iterator.Element]] {
        var i = 0
        var result :[[Iterator.Element]] = []
        
        var xs : [Iterator.Element] = []
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
    public func sortByProperty<T: Comparable>(_ ascending: Bool = true, fn: (Iterator.Element) -> T) -> [Iterator.Element] {
        
        return sorted {
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
    public func pluck<T>(_ fn: (Iterator.Element) -> T) -> [T] {
        return map { fn($0) }
    }
    
    public func filterMax<E: Comparable & Hashable>(_ fn:(Iterator.Element) -> E?) -> [Iterator.Element] {
        
        var maximums: [Iterator.Element] = []
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
    public func first(_ count: Int) -> [Iterator.Element] {
        var result: [Iterator.Element] = []
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
    
    /*
        Map with an index
    */
    public func indexMap<T>(_ fn: (Int, Iterator.Element) -> T) -> [T] {
        var result: [T] = []
        for (index, obj) in enumerated() {
            let mappedObject = fn(index, obj)
            result.append(mappedObject)
        }
        return result
    }
    
    public func match<E, T>(xs: [E], ys: [T], fn: (E, T) -> Bool) -> [(E, T)] {
        var results = [(E, T)]()
        //: OPTIMIZE
        // O(n^3)  There's probably a much better way to do this.  It probably involves sets
        for x in xs {
            for y in ys {
                if fn(x, y) {
                    results.append(x, y)
                }
            }
        }
        return results
    }
}
