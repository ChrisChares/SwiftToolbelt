//
//  Request.swift
//  HuntFish
//
//  Created by Chris Chares on 1/29/16.
//  Copyright © 2016 303 Software. All rights reserved.
//

import Foundation
import Alamofire

/*:
    Wrappers, typealias and assorted functions to make dealing with JSON and networking requests less ugly

*/

let manager: Alamofire.Manager = {
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    configuration.HTTPMaximumConnectionsPerHost = 1
    let manager = Alamofire.Manager(configuration: configuration)
    return manager
}()

public typealias JSON = [String: AnyObject]

// For Responses that expect a JSON object at the top level
public func Request(req: URLRequestConvertible, fn: (Result<JSON>)-> Void) {
    manager.request(req)
        .responseJSON(completionHandler: { (response) -> Void in
            do {
                let result = try response.result.unwrap()
                let json = try cast(result) as JSON
                try validateResponse(response.response!.statusCode, json: json)
                fn(Result({json}))
            } catch let error {
                fn(Result({throw error}))
            }
        })
}
//
//// For responses that expect an array of JSON objects at the top level
public func Request(req: URLRequestConvertible, fn: (Result<[JSON]>)-> Void) {
    manager.request(req)
        .responseJSON(completionHandler: { (response) -> Void in
            do {
                let result = try response.result.unwrap()
                if result is JSON {
                    try validateResponse(response.response!.statusCode, json: result as! JSON)
                }
                
                let json = try toJSONArray(result)
                
                fn(Result({json}))
            } catch let error {
                fn(Result({throw error}))
            }
        })
}


public func wrap<T>(cb: (Result<T>) -> Void, fn: () throws -> T) {
    cb(Result({try fn()}))
}

public protocol ErrorParser {
    associatedtype T
    func validate(status: Int?, value: T) throws
}

public struct JSONErrorParser : ErrorParser {
    public typealias T = JSON
    public func validate(status: Int?, value: JSON) throws {
        guard let s = status where s > 199 && s < 300 else {
            let message = value["message"] as? String ?? "Error: \(status!)"
            throw APIError.ServerError(code: status!, message: message)
        }
    }
}

public struct JSONArrayErrorParser : ErrorParser {
    public typealias T = [JSON]
    public func validate(status: Int?, value: [JSON]) throws {
        guard let s = status where s > 199 && s < 300 else {
            let message = "Error: \(status!)"
            throw APIError.ServerError(code: status!, message: message)
        }
    }
}

public func Request<T, E: ErrorParser where E.T == T>(req: URLRequestConvertible, errorParser: E? = nil,fn: (Result<T>) -> Void) {
    manager.request(req)
        .responseJSON(completionHandler: { (response) -> Void in
            wrap(fn) {
                let result = try response.result.unwrap()
                let typedResult = try cast(result) as T
                if let e = errorParser {
                    try e.validate(response.response?.statusCode, value: typedResult)
                }
                return typedResult
            }
        })
}

public protocol Parser {
    associatedtype Type
}

//protocol Route {
//    var request: URLRequestConvertible { get }
//    var parser
//}

//class Request {
//    
//}

public func RequestJSON(req: URLRequestConvertible, fn: (Result<JSON>) -> Void) {
    Request(req, errorParser: JSONErrorParser(), fn: fn)
}
public func RequestJSONArray(req: URLRequestConvertible, fn: (Result<[JSON]>) -> Void) {
    Request(req, errorParser: JSONArrayErrorParser(), fn: fn)
}



public extension Result {
    /**
     Wrap a Alamofire result enum in a Result struct
     
     - Parameter res: an Alamofire Result object
     - Returns: A Result struct wrapping the Alamofire response
     */
    static func af(res: Alamofire.Result<AnyObject, NSError>) -> Result<AnyObject> {
        switch res {
        case .Success(let value):
            return Result<AnyObject>({value})
        case .Failure(let error):
            return Result<AnyObject>({throw error})
        }
    }
}


public extension Alamofire.Result {
    func unwrap() throws -> Value {
        switch self {
        case .Success(let value):
            return value
        case .Failure(let error):
            throw error
        }
    }
}

private func validateResponse(statusCode: Int, json: JSON) throws {
    guard statusCode < 400 else {
        let message = json["message"] as? String ?? "An unknown error occured"
        throw APIError.ServerError(code: statusCode, message: message)
    }
}

public enum APIError : ErrorType {
    case ServerError(code: Int, message: String)
}

public enum ParsingError : ErrorType {
    case UnableToConvertToJSON
    case UnableToConvertToJSONArray
    case InvalidJSON
    case NoValidObjects
}

public enum TypeError : ErrorType {
    case WrongType
}

public func cast<T>(value: AnyObject) throws -> T {
    if let obj = value as? T {
        return obj
    } else {
        throw TypeError.WrongType
    }
}

public func toJSON(value: AnyObject) throws -> JSON {
    if let json = value as? JSON {
        return json
    } else {
        throw ParsingError.UnableToConvertToJSON
    }
}

public func toJSONArray(value: AnyObject) throws -> [JSON] {
    if let json = value as? [JSON] {
        return json
    } else {
        throw ParsingError.UnableToConvertToJSONArray
    }
}
