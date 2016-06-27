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

// For Responses that expect a JSON object at the top level
public func RequestJSON(req: URLRequestConvertible, validation: ValidationFunction = RequestValidationFunction, fn: (Result<JSON>)-> Void) {
    
    let session = NSURLSession.sharedSession()
    session.dataTaskWithRequest(req.URLRequest) { (data, response, error) in
        backgroundWrap(fn) {
            guard error == nil else { throw error! }
            guard let data = data else { throw APIError.NoResponseData }
            guard let httpResponse = response as? NSHTTPURLResponse else { throw APIError.NoResponseData }
            
            let json = try cast(NSJSONSerialization.JSONObjectWithData(data, options: [])) as JSON
            
            try validation(httpResponse.statusCode, json)
            
            return json
        }
    }.resume()
}

// For responses that expect an array of JSON objects at the top level
public func RequestJSONArray(req: URLRequestConvertible, validation: ValidationFunction = RequestValidationFunction, fn: (Result<[JSON]>)-> Void) {
    let session = NSURLSession.sharedSession()
    session.dataTaskWithRequest(req.URLRequest) { (data, response, error) in
        backgroundWrap(fn) {
            guard error == nil else { throw error! }
            guard let data = data else { throw APIError.NoResponseData }
            guard let httpResponse = response as? NSHTTPURLResponse else { throw APIError.NoResponseData }
            
            let anyObject = try NSJSONSerialization.JSONObjectWithData(data, options: [])
            try validation(httpResponse.statusCode, anyObject as? JSON)
            
            let jsonArray = try cast(anyObject) as [JSON]
            return jsonArray
        }
    }.resume()
}

public typealias ValidationFunction = (Int, JSON?) throws -> Void

public var RequestValidationFunction: ValidationFunction = validateResponse

private func validateResponse(statusCode: Int, json: JSON?) throws {
    guard statusCode < 400 else {
        let message = json?["message"] as? String ?? "An unknown error occured"
        throw APIError.ServerError(code: statusCode, message: message)
    }
}

public enum APIError : ErrorType {
    case ServerError(code: Int, message: String)
    case NoResponseData
}

public enum ParsingError : ErrorType {
    case InvalidJSON
    case NoValidObjects
}


