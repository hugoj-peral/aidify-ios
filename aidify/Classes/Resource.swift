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
}

protocol Resource {
    var method: Method { get }
    var path: String { get }
    var parameters: [String: String] { get }
}

extension Resource {
    
    var method: Method {
        return .GET
    }
    
    func requestWithBaseURL(baseURL: NSURL) -> NSURLRequest {
        let URL = baseURL.URLByAppendingPathComponent(path)
        
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
        
        let request = NSMutableURLRequest(URL: finalURL)
        request.HTTPMethod = method.rawValue
        
        return request
    }
}

