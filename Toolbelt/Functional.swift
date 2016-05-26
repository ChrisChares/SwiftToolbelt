//
//  Functional.swift
//  HuntFish
//
//  Created by Chris Chares on 2/1/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

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

extension CollectionType {
    func chunk(size: Int) -> [[Generator.Element]] {
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
}
//: Creates a function that invokes func, while it’s called less than n times. Subsequent calls to the created function return the result of the last func invocation.
func before<T>(n: Int, fn: () -> T) -> () -> T {
    guard n > 0 else {
        fatalError("Can't call with n < 1")
    }
    var i = 0
    var lastValue: T = fn()
    return {
        if i == 0 {
            i += 1
            return lastValue
        }
        else if i < n {
            lastValue = fn()
            i += 1
        }
        return lastValue
    }
}

//: Creates a function that is restricted to invoking func once. Repeat calls to the function return the value of the first invocation. The func is invoked with the this binding and arguments of the created function.
func once(fn: ()-> Void) -> () -> Void {
    var run = false
    return {
        if run == false {
            run = true
            fn()
        }
    }
}
//: Seconds
func throttle(wait: Double, fn: ()->Void) -> () -> Void {
    var lastInvoked = NSDate.distantPast()
    return {
        if NSDate().timeIntervalSinceDate(lastInvoked) > wait {
            lastInvoked = NSDate()
            fn()
        }
    }
}

//: Creates a function that invokes func with arguments reversed.
func flip<E, T, Z>(fn: (E, T) -> Z) -> (T, E) -> Z {
    return { (t: T, e:E) in
        return fn(e, t)
    }
}

//: Creates a function that negates the result of the predicate func. The func predicate is invoked with the this binding and arguments of the created function.
//Seems to be of little use in Swift, unless I'm missing something
func negate(@autoclosure fn: () -> Bool) -> () -> Bool {
    let bool = fn()
    return {
        return (bool == false) ? true : false
    }
}




