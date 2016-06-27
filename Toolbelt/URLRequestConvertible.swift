//
//  URLRequestConvertible.swift
//  Toolbelt
//
//  Created by Chris Chares on 6/24/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation

public protocol URLRequestConvertible {
    var URLRequest: NSMutableURLRequest { get }
}

extension NSMutableURLRequest {
    override public var URLRequest: NSMutableURLRequest { return self }
}

extension NSURLRequest : URLRequestConvertible {
    public var URLRequest: NSMutableURLRequest { return mutableCopy() as! NSMutableURLRequest }
}

extension NSURL : URLRequestConvertible {
    public var URLRequest : NSMutableURLRequest { return NSMutableURLRequest(URL: self) }
}

extension String : URLRequestConvertible {
    public var URLRequest : NSMutableURLRequest { return NSMutableURLRequest(URL: NSURL(string: self)!) }
}
