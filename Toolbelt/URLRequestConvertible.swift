//
//  URLRequestConvertible.swift
//  Toolbelt
//
//  Created by Chris Chares on 6/24/16.
//  Copyright © 2016 Chris Chares. All rights reserved.
//

import Foundation

public protocol URLRequestConvertible {
    var request: URLRequest { get }
}


extension Foundation.URLRequest : URLRequestConvertible {
    public var request: URLRequest {
        return self
    }
}

extension URL : URLRequestConvertible {
    public var request : URLRequest {
        return URLRequest(url: self)
    }
}

extension String : URLRequestConvertible {
    public var request : URLRequest {
        let url = URL(string: self)!
        return URLRequest(url: url)
    }
}
