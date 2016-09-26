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
public extension NSURL {
    public static var temporaryURL: NSURL {
        return try! NSFileManager.defaultManager().URLForDirectory(NSSearchPathDirectory.CachesDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true).URLByAppendingPathComponent(NSUUID().UUIDString)!
    }
    
    public static var documentsURL: NSURL {
        return try! NSFileManager.defaultManager().URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
    }
}
