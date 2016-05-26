//
//  String.swift
//  Playerbook
//
//  Created by Chris Chares on 4/4/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

private let numberFormatter = NSNumberFormatter()

extension String {
    var intValue: Int? {
        return numberFormatter.numberFromString(self)?.integerValue
    }
    
    func contains(text: String, ignoreCase: Bool = true) -> Bool {
        guard text != "" else {
            return true
        }
        
        var options = NSStringCompareOptions()
        if ignoreCase { options.unionInPlace(.CaseInsensitiveSearch) }
        return self.rangeOfString(text, options: options) != nil
    }
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range <Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
    
    var length: Int {
        return self.characters.count
    }
    
    var lastCharacter: String? {
        return length == 0 ? nil : self[length - 1]
    }
    
    mutating func insert(string: String, index: Int) -> String {
        if index == self.length {
            self += string
        } else {
            self = String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count - index))
        }
        
        return self
    }
    
    mutating func removeAtIndex(i: Int) {
        self.removeAtIndex(self.startIndex.advancedBy(i))
    }    
}