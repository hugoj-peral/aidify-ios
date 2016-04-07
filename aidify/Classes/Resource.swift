//
//  Resource.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

enum Method: String {
    case GET
    case POST
    case PUT
}

enum Auth: Equatable {
    case None
    case Basic(user: String, pass: String)
}
func ==(lhs: Auth, rhs: Auth) -> Bool {
    return String(lhs) == String(rhs)
}


extension Auth: CustomStringConvertible {
    var description: String {
        switch self {
        case .None:
            return ""
        case let .Basic(user, pass):
            let loginString = NSString(format: "%@:%@", user, pass)
            let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
            let base64LoginString = loginData.base64EncodedStringWithOptions([])
            return "Basic \(base64LoginString)"
        }
    }
}

protocol Resource {
    var method: Method { get }
    var path: String { get }
    var pathParameters: [String] { get }
    var parameters: [String: AnyObject] { get }
    var auth: Auth { get }
}

extension Resource {
    
    var method: Method {
        return .GET
    }
    
    var auth: Auth {
        return .None
    }
    
    var pathParameters: [String] {
        return []
    }
    
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest {
        var URL = baseURL.URLByAppendingPathComponent(path)
            
        if (pathParameters.count > 0) {
           URL = URL.URLByAppendingPathComponent(pathParameters.joinWithSeparator("/"))
        }
        
        var request: NSMutableURLRequest
        
        switch method {
        case .GET:
            request = getRequestWithBaseURL(URL)
        case .POST, .PUT:
            request = postRequestWithBaseURL(URL)
        }
        
        request.HTTPMethod = method.rawValue
        
        if auth != .None {
            request.addValue(auth.description, forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
    
    private func getRequestWithBaseURL(URL: NSURL) -> NSMutableURLRequest {
        // NSURLComponents can fail due to programming errors, so
        // prefer crashing than returning an optional
        
        guard let components = NSURLComponents(URL: URL, resolvingAgainstBaseURL: false) else {
            fatalError("Unable to create URL components from \(URL)")
        }
        
        components.queryItems = parameters.map {
            NSURLQueryItem(name: String($0), value: String($1))
        }
        
        guard let finalURL = components.URL else {
            fatalError("Unable to retrieve final URL")
        }
        
        return NSMutableURLRequest(URL: finalURL)
    }
    
    private func postRequestWithBaseURL(URL: NSURL) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(URL: URL)
        
        if let jsonData = try? NSJSONSerialization.dataWithJSONObject(parameters, options: []){
            request.HTTPBody = jsonData
        }
        
        return request
    }
}

