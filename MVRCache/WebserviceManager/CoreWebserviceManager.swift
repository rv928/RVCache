//
//  CoreWebserviceManager.swift
//  MVRCache
//
//  Created by Admin on 26/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
 // Singleton for Webservice parsing POST and GET method

class CoreWebserviceManager {
    
    static let manager : CoreWebserviceManager = {
        let manager = CoreWebserviceManager()
        return manager
    }()
    
    private init() {
        
    }
    
    func PostWeb_Service_Body(_ url:String,authToken:String,httpMethod:String,parameters:[String:AnyObject],completionHandler: @escaping (Data?,URLResponse?,Error?) -> Void) {
        
        let defaultConfigObject: URLSessionConfiguration = URLSessionConfiguration.default
        let delegateFreeSession: URLSession = URLSession(configuration: defaultConfigObject)
        let url: URL = URL(string: "\(url)")!
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.addValue(RequestConstant.kAcceptType, forHTTPHeaderField: RequestConstant.kContentType)
        
        if authToken.count>0 {
            urlRequest.addValue(authToken, forHTTPHeaderField: RequestConstant.kauthorization)
        }
        urlRequest.httpMethod = httpMethod
        var jsonData: Data?
        do {
            try jsonData = JSONSerialization .data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            
        } catch {
            print("error: \(error)")
        }
        var jsonString: String
        jsonString = String(data: jsonData!, encoding: String.Encoding.utf8)!
        print("======================================================================")
        print("url\n \(url)")
        print("======================================================================")
        print("jsonString\n \(jsonString)")
        print("======================================================================")
        urlRequest.httpBody = jsonString.data(using: String.Encoding.utf8)
        urlRequest.timeoutInterval = 120.0
        var dataTask: URLSessionDataTask
        dataTask = delegateFreeSession.dataTask(with: urlRequest, completionHandler: {(data : Data?, response : URLResponse?, error :Error?) in
            
            completionHandler(data,response,error)
            
        });
        dataTask.resume()
    }
    
    func PostWeb_Service(_ url:String,authToken:String,httpMethod:String,parameters:[String:AnyObject],completionHandler: @escaping (Data?,URLResponse?,Error?) -> Void) {
        
        let defaultConfigObject: URLSessionConfiguration = URLSessionConfiguration.default
        let delegateFreeSession: URLSession = URLSession(configuration: defaultConfigObject)
        let url: URL = URL(string: "\(url)")!
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.addValue(RequestConstant.kApplicationHeader, forHTTPHeaderField: RequestConstant.kContentType)
        urlRequest.httpMethod = httpMethod
        var jsonData: Data
        jsonData = "\(url)&\(parameters.stringFromHttpParameters())".data(using: String.Encoding.ascii)!
        var jsonString: String
        jsonString = String(data: jsonData, encoding: String.Encoding.utf8)!
        urlRequest.httpBody = jsonString.data(using: String.Encoding.utf8)
        urlRequest.timeoutInterval = 120.0
        var dataTask: URLSessionDataTask
        dataTask = delegateFreeSession.dataTask(with: urlRequest, completionHandler: {(data : Data?, response : URLResponse?, error : Error?) in
            
            completionHandler(data,response,error)
            
        } );
        dataTask.resume()
    }
    
    func GetWeb_Service(_ url:String,authToken:String,httpMethod:String,completionHandler: @escaping (Data?,URLResponse?,Error?) -> Void) {
        
        let defaultConfigObject: URLSessionConfiguration = URLSessionConfiguration.default
        let delegateFreeSession: URLSession = URLSession(configuration: defaultConfigObject)
        let url: URL = URL(string: "\(url)")!
        var urlRequest: URLRequest = URLRequest(url: url)
        urlRequest.addValue(RequestConstant.kApplicationHeader, forHTTPHeaderField: RequestConstant.kContentType)
        if authToken.count>0 {
            urlRequest.addValue(authToken, forHTTPHeaderField: RequestConstant.kauthorization)
        }
        urlRequest.httpMethod = httpMethod
        urlRequest.timeoutInterval = 120.0
        var dataTask: URLSessionDataTask
        dataTask = delegateFreeSession.dataTask(with: urlRequest, completionHandler: {(data  , response  , error ) -> Void in
            completionHandler(data,response,error)
        })
        dataTask.resume()
    }
   
}
