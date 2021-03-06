//
//  Functional.swift
//  HuntFish
//
//  Created by Chris Chares on 2/1/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

/*
    Currying
*/
public func curry<A,B,C>(_ fn: @escaping (A,B) -> C) -> (A) -> (B) -> C {
    return { a in
        return { b in
            fn(a,b)
        }
    }
}

public func curry<A,B,C,D>(_ fn: @escaping (A,B,C) -> D) -> (A) -> (B) -> (C) -> D {
    return { a in
        return { b in
            return { c in
                return fn(a,b,c)
            }
        }
    }
}


//: Creates a function that invokes func, while it’s called less than n times. Subsequent calls to the created function return the result of the last func invocation.
public func before<T>(_ n: Int, fn: @escaping () -> T) -> () -> T {
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
public func once(_ fn: @escaping ()-> Void) -> () -> Void {
    var run = false
    return {
        if run == false {
            run = true
            fn()
        }
    }
}
//: Seconds
public func throttle(_ wait: Double, fn: @escaping ()->Void) -> () -> Void {
    var lastInvoked = Date.distantPast
    return {
        if Date().timeIntervalSince(lastInvoked) > wait {
            lastInvoked = Date()
            fn()
        }
    }
}

//: Creates a function that invokes func with arguments reversed.
public func flip<E, T, Z>(_ fn: @escaping (E, T) -> Z) -> (T, E) -> Z {
    return { (t: T, e:E) in
        return fn(e, t)
    }
}

//: Creates a function that negates the result of the predicate func. The func predicate is invoked with the this binding and arguments of the created function.
//Seems to be of little use in Swift, unless I'm missing something
public func negate(_ fn: @autoclosure () -> Bool) -> () -> Bool {
    let bool = fn()
    return {
        return (bool == false) ? true : false
    }
}




