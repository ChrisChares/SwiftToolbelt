//
//  Array.swift
//  Playerbook
//
//  Created by Chris Chares on 4/5/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

extension Array {
    func sortByProperty<T: Comparable>(ascending: Bool = true, fn: (Generator.Element) -> T) -> [Generator.Element] {
        
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
    
    func pluck<T>(fn: (Generator.Element) -> T) -> [T] {
        return map { fn($0) }
    }
}
