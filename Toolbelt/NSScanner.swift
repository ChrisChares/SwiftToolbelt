//
//  NSScanner.swift
//  Advent
//
//  Created by Chris Chares on 3/20/16.
//  Copyright © 2016 303Software. All rights reserved.
//

import Foundation

public extension Scanner {
    public func scanInt() -> Int? {
        var int : CInt = 0
        let didScan = scanInt32(&int)
        return didScan ? Int(int) : nil
    }
    
    public func scanDouble() -> Double? {
        var double : CDouble = 0.0
        let didScan = scanDouble(&double)
        return didScan ? Double(double) : nil
    }
    
    public func scanRawRepresentableUpToCharacters<T: RawRepresentable>(_ toCharacters: CharacterSet) -> T? where T.RawValue == String {
        if let raw = scanUpToCharacters(toCharacters) {
            return T(rawValue: raw)
        } else {
            return nil
        }
    }
    
    public func scan(_ token : String) -> Bool {
        return scanString(token, into: nil)
    }
    
    public func scanUpToString(_ toString: String) -> String? {
        var string : NSString?
        scanUpTo(toString, into: &string)
        return string as? String
    }
    
    public func scanUpToCharacters(_ toCharacters: CharacterSet) -> String? {
        var string : NSString?
        self.scanUpToCharacters(from: toCharacters, into: &string)
        return string as? String
    }
}

/*
public extension _ArrayType where Iterator.Element == String {
    public func scanMap<E>(_ config: ((String) -> Scanner)?, fn: (Scanner) -> E) -> [E] {
        
        var configFunction: ((String) -> Scanner)! = config
        if configFunction == nil {
            configFunction = { string in
                return Scanner(string: string)
            }
        }
        
        var xs = [E]()
        for string in self {
            xs.append(fn(configFunction(string)))
        }
        
        return xs
    }
}
*/
