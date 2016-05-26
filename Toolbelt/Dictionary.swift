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
