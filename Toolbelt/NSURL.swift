//
//  objcio.swift
//  Playerbook
//
//  Created by Chris Chares on 3/17/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

/*
 Stuff from objc.io
 */
public extension URL {
    public static var temporaryURL: URL {
        return try! FileManager.default.url(for: FileManager.SearchPathDirectory.cachesDirectory, in: .userDomainMask, appropriateFor: nil, create: true).appendingPathComponent(UUID().uuidString)
    }
    
    public static var documentsURL: URL {
        return try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    }
}
