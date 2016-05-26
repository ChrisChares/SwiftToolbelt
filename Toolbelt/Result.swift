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
struct Result<T> {
    typealias Eval = () throws -> T
    private let fn: Eval
    /**
        Create a new Result struct with the function to be evaluated
     
        - Parameter fn: The function to evaluate
        - Returns: A new Result struct wrapping the function
    */
    init(_ fn: Eval) {
        self.fn = fn
    }
    /**
        Evaluate the wrapped function
     
        - Throws: Whatever error the original asynchronous action threw
        - Returns: The object associated with a success
    */
    func eval() throws -> T {
        return try fn()
    }
    
    
    /**
        Evaluate the wrapped function and return an error optional based on result
    */
    var error: ErrorType? {
        return ErrorOptional(eval)
    }
    
    /**
        For other situations where response doesn't matter, only errors do
    */
    func rethrow() throws {
        try fn()
    }
}

/**
    Maps any Result<E> to Result<Void>.  Useful for chaining
 
 */
func AnyResult<E>(fn: (Result<Void>) -> Void) -> (Result<E>) -> Void {
    
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
func ResultAccumulator<T>(fn: (Result<[T]>) -> Void) -> () -> (Result<T>) -> Void {
    
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

func ErrorOptional<T>(fn: () throws -> T) -> ErrorType? {
    do {
        try fn()
        return nil
    } catch let error {
        return error
    }
}