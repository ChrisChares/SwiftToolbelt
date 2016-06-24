//
//  Request.swift
//  HuntFish
//
//  Created by Chris Chares on 1/29/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation

/*:
    Wrappers, typealias and assorted functions to make dealing with JSON and networking requests less ugly

*/
public protocol URLRequestConvertible {
    var URLRequest: NSURLRequest { get }
}


// For Responses that expect a JSON object at the top level
public func Request(req: URLRequestConvertible, fn: (Result<JSON>)-> Void) {
    
    let session = NSURLSession.sharedSession()
    session.dataTaskWithRequest(req.URLRequest) { (data, response, error) in
        backgroundWrap(fn) {
            guard error == nil else { throw error! }
            guard let data = data else { throw RequestError.NoResponseData }
            guard let httpResponse = response as? NSHTTPURLResponse else { throw RequestError.NoResponseData }
            
            let json = try cast(NSJSONSerialization.JSONObjectWithData(data, options: [])) as JSON
            
            try validateResponse(httpResponse.statusCode, json: json)
            
            return json
        }
    }.resume()
}

// For responses that expect an array of JSON objects at the top level
public func Request(req: URLRequestConvertible, fn: (Result<[JSON]>)-> Void) {
    let session = NSURLSession.sharedSession()
    session.dataTaskWithRequest(req.URLRequest) { (data, response, error) in
        backgroundWrap(fn) {
            guard error == nil else { throw error! }
            guard let data = data else { throw RequestError.NoResponseData }
            guard let httpResponse = response as? NSHTTPURLResponse else { throw RequestError.NoResponseData }
            
            let anyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            if let json = anyObject as? JSON {
                try validateResponse(httpResponse.statusCode, json: json)
            }
            
            let jsonArray = try cast(anyObject) as [JSON]
            return jsonArray
        }
    }.resume()
}

private func validateResponse(statusCode: Int, json: JSON) throws {
    guard statusCode < 400 else {
        let message = json["message"] as? String ?? "An unknown error occured"
        throw APIError.ServerError(code: statusCode, message: message)
    }
}

public enum RequestError : ErrorType {
    case NoResponseData
}

public enum APIError : ErrorType {
    case ServerError(code: Int, message: String)
}

public enum ParsingError : ErrorType {
    case InvalidJSON
    case NoValidObjects
}


