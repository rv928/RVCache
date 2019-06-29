//
//  URLConstant.swift
//  MVRCache
//
//  Created by Admin on 26/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation


//HostURL

let k_APIHost     = "http://pastebin.com/"
let k_APIUserList = "raw/wgkJgazE"

//http://pastebin.com/raw/wgkJgazE


struct RequestConstant {
    
    static let kGET  = "GET"
    static let kPUT  = "PUT"
    static let kPOST = "POST"
    
    static let kApplicationHeader        =  "application/x-www-form-urlencoded"
    static let kContent                  =  "Content-type"
    static let kJSONContent              =  "application/json; charset=UTF-8"
    static let kAccept                   =  "Accept"
    static let kAcceptType               =  "application/json"
    static let kContentLength            =  "Content-Length"
    static let kauthorization            =  "Authorization"
    static let kContentType              =  "application/json"
}
