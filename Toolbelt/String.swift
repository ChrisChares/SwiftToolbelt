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
}