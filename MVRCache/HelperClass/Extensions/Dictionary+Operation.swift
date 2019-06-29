//
//  Dictionary+Operation.swift
//  MVRCache
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation

// MARK: Dictionary to String Encoding
extension Dictionary {
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).stringByAddingPercentEncodingForURLQueryValue()!
            if value is NSNumber {
                let percentEscapedValue = (value as! NSNumber).stringValue.stringByAddingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            } else {
                let percentEscapedValue = (value as! String).stringByAddingPercentEncodingForURLQueryValue()!
                return "\(percentEscapedKey)=\(percentEscapedValue)"
            }
        }
        return parameterArray.joined(separator: "&")
    }
    
}
