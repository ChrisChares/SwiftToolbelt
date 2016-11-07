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
public func RequestJSON(_ req: URLRequestConvertible, validation: @escaping ValidationFunction = RequestValidationFunction, fn: @escaping (Result<JSON>)-> Void) {
    
    let session = URLSession.shared
    session.dataTask(with: req.request, completionHandler: { (data, response, error) in
        backgroundWrap(fn) {
            guard error == nil else { throw error! }
            guard let data = data else { throw APIError.noResponseData }
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError.noResponseData }
            
            let any = try JSONSerialization.jsonObject(with: data, options: [])
            let json = try cast(any) as JSON
            
            try validation(httpResponse.statusCode, json)
            return json
        }
    }) .resume()
}

// For responses that expect an array of JSON objects at the top level
public func RequestJSONArray(_ req: URLRequestConvertible, validation: @escaping ValidationFunction = RequestValidationFunction, fn: @escaping (Result<[JSON]>)-> Void) {
    let session = URLSession.shared
    session.dataTask(with: req.request, completionHandler: { (data, response, error) in
        backgroundWrap(fn) {
            guard error == nil else { throw error! }
            guard let data = data else { throw APIError.noResponseData }
            guard let httpResponse = response as? HTTPURLResponse else { throw APIError.noResponseData }
            
            let anyObject = try JSONSerialization.jsonObject(with: data, options: [])
            try validation(httpResponse.statusCode, anyObject as? JSON)
            
            let jsonArray = try cast(anyObject) as [JSON]
            return jsonArray
        }
    }) .resume()
}

public typealias ValidationFunction = (Int, JSON?) throws -> Void

public var RequestValidationFunction: ValidationFunction = validateResponse

private func validateResponse(_ statusCode: Int, json: JSON?) throws {
    guard statusCode < 400 else {
        let message = json?["message"] as? String ?? "An unknown error occured"
        throw APIError.serverError(code: statusCode, message: message)
    }
}

public enum APIError : Error {
    case serverError(code: Int, message: String)
    case noResponseData
}

public enum ParsingError : Error {
    case invalidJSON
    case noValidObjects
}
