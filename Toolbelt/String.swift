//
//  String.swift
//  Playerbook
//
//  Created by Chris Chares on 4/4/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

private let numberFormatter = NSNumberFormatter()

public extension String {
    public var intValue: Int? {
        return numberFormatter.numberFromString(self)?.integerValue
    }
    
    public func contains(text: String, ignoreCase: Bool = false) -> Bool {
        guard text != "" else {
            return true
        }
        
        var options = NSStringCompareOptions()
        if ignoreCase { options.unionInPlace(.CaseInsensitiveSearch) }
        return self.rangeOfString(text, options: options) != nil
    }
    
    public subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    public subscript (r: Range <Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
    
    public var length: Int {
        return self.characters.count
    }
    
    public var lastCharacter: String? {
        return length == 0 ? nil : self[length - 1]
    }
    
    public mutating func insert(string: String, index: Int) -> String {
        if index == self.length {
            self += string
        } else {
            self = String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count - index))
        }
        
        return self
    }
    
    public mutating func removeAtIndex(i: Int) {
        self.removeAtIndex(self.startIndex.advancedBy(i))
    }    
}