//
//  Dictionary.swift
//  Playerbook
//
//  Created by Chris Chares on 4/5/16.
//  Copyright © 2016 303 Software. All rights reserved.
//
public extension Dictionary where Key: Comparable {
    public func sortByKey(ascending: Bool = true) -> [(Key, Value)] {
        return self.sort {
            if ascending {
                return $0.0 < $1.0
            } else {
                return $0.0 > $1.0
            }
        }
    }
}

public extension Dictionary {
    /*
        Merge two dictionaries together.  The parameter dictionary's values will overwrite the receiver's if keys collide
    */
    public func merge(other: Dictionary) -> Dictionary {
        var result = self
        for (key, value) in other {
            result[key] = value
        }
        return result
    }
}



