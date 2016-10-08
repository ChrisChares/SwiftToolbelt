//
//  String.swift
//  Playerbook
//
//  Created by Chris Chares on 4/4/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

private let numberFormatter = NumberFormatter()

public extension String {
    public var intValue: Int? {
        return numberFormatter.number(from: self)?.intValue
    }
    
    public func contains(_ text: String, ignoreCase: Bool = false) -> Bool {
        guard text != "" else {
            return true
        }
        
        var options = NSString.CompareOptions()
        if ignoreCase { options.formUnion(.caseInsensitive) }
        return self.range(of: text, options: options) != nil
    }
    
    public subscript (i: Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: i)]
    }
    
    public subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
  //  public subscript (r: Range <Int>) -> String {
   //     let start = characters.index(startIndex, offsetBy: r.lowerBound)
    //    let end = start
    //    let end = <#T##String.CharacterView corresponding to `start`##String.CharacterView#>.index(start, offsetBy: r.upperBound - r.lowerBound)
//       return self[Range(start ..< end)]
 //   }
    
    public var length: Int {
        return self.characters.count
    }
    
    public var lastCharacter: String? {
        return length == 0 ? nil : self[length - 1]
    }
    
    public mutating func insert(_ string: String, index: Int) -> String {
        if index == self.length {
            self += string
        } else {
            self = String(self.characters.prefix(index)) + string + String(self.characters.suffix(self.characters.count - index))
        }
        
        return self
    }
    
    public mutating func removeAtIndex(_ i: Int) {
        self.remove(at: self.characters.index(self.startIndex, offsetBy: i))
    }    
}
