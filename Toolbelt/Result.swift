//
//  Result.swift
//  HuntFish
//
//  Created by Chris Chares on 1/20/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

/**
    A wrapper that allows us to utilize native Swift error handling (do - try - catch - defer) with asynchronous operations.  The idea is derived from Benedikt Terhechte's excellent post http://appventure.me/2015/06/19/swift-try-catch-asynchronous-closures/
*/
open class Result<T> {
    public typealias Eval = () throws -> T
    fileprivate let fn: Eval
    /**
        Create a new Result struct with the function to be evaluated
     
        - Parameter fn: The function to evaluate
        - Returns: A new Result struct wrapping the function
    */
    public init(_ fn: @escaping Eval) {
        self.fn = fn
    }
    /**
        Evaluate the wrapped function
     
        - Throws: Whatever error the original asynchronous action threw
        - Returns: The object associated with a success
    */
    open func eval() throws -> T {
        return try fn()
    }
    
    
    /**
        Evaluate the wrapped function and return an error optional based on result
    */
    open var error: Error? {
        return ErrorOptional(eval)
    }
    
    /**
        For other situations where response doesn't matter, only errors do
    */
    open func rethrow() throws {
        _ = try fn()
    }
}

/**
    Maps any Result<E> to Result<Void>.  Useful for chaining
 
 */
public func AnyResult<E>(_ fn: @escaping (Result<Void>) -> Void) -> (Result<E>) -> Void {
    
    return { result in
        if let error = result.error {
            fn(Result({throw error}))
        } else {
            fn(Result({}))
        }
    }
}

/**
    Creates one callback out of multiple of the same type
*/
public func ResultAccumulator<T>(_ fn: @escaping (Result<[T]>) -> Void) -> () -> (Result<T>) -> Void {
    
    var results = [T]()
    var requestCount: Int = 0
    var errored: Bool = false
    
    return {
        requestCount = requestCount + 1
        
        return { result in
            guard errored == false else {
                // All results are cancelled because one failed
                return
            }
            
            do {
                results.append(try result.eval())
                
                if results.count == requestCount {
                    fn(Result({results}))
                }
            } catch let error {
                errored = true
                fn(Result({throw error}))
            }
        }
    }
}

public func ErrorOptional<T>(_ fn: () throws -> T) -> Error? {
    do {
        _ = try fn()
        return nil
    } catch let error {
        return error
    }
}

/*
    Wrap makes async functions w/ callbacks less awkward as it lets you write in a more linear fashion
*/
public func wrap<T>(_ cb: (Result<T>) -> Void, fn: @escaping () throws -> T) {
    cb(Result({try fn()}))
}
/*
    Background wrap works similiarly to wrap, except it performs the passed function on a background thread.  Results / errors are returned on the main thread
 */
public func backgroundWrap<T>(_ cb: @escaping  (Result<T>) -> Void, fn: @escaping  () throws -> T) {
    
    let main = DispatchQueue.main
    let bg = DispatchQueue.global(qos: .background)
    
    bg.async {
        do {
            let result = try fn()
            main.async { cb(Result({result})) }
        } catch let error {
            main.async { cb(Result({throw error})) }
        }
    }
}

