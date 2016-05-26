//
//  CollectionType.swift
//  Toolbelt
//
//  Created by Chris Chares on 5/26/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

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