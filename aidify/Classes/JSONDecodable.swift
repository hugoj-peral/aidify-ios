//
//  JSONDecodable.swift
//  aidify
//
//  Created by Hugo Peral on 24/3/16.
//  Copyright © 2016 aidify. All rights reserved.
//

import Foundation

typealias JSONDictionary = [String: AnyObject]

protocol JSONDecodable {
    init?(dictionary: JSONDictionary)
}

func decode<T: JSONDecodable>(dictionaries: [JSONDictionary]) -> [T] {
    return dictionaries.flatMap { T(dictionary: $0) }
}

func decode<T: JSONDecodable>(dictionary: JSONDictionary) -> T? {
    return T(dictionary: dictionary)
}

func decode<T:JSONDecodable>(data: NSData) -> [T]? {
    guard let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
        dictionaries = JSONObject as? [JSONDictionary],
        objects: [T] = decode(dictionaries) else {
            return nil
    }
    
    return objects
}

func decode<T:JSONDecodable>(data: NSData) -> T? {
    guard let JSONObject = try? NSJSONSerialization.JSONObjectWithData(data, options: []),
        dictionary = JSONObject as? JSONDictionary,
        object: T = decode(dictionary) else {
            return nil
    }
    
    return object
}
