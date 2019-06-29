//
//  RequestManager.swift
//  MVRCache
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

class RequestManager {
    
    static let manager : RequestManager = {
        let manager = RequestManager()
        return manager
    }()
    
    private init() {
        
    }
    
    func fetchData(_ viewController:UIViewController?, dictparamters : Dictionary<String,Any>? ,APIName:String?,HTTPType :String?,completion: @escaping (_ responseDictionary : Dictionary<String,Any>?) -> Void) {
        
            SharedClass.sharedInstance.hasConnectivity(completion: { (checkConnection:String?) -> Void in
                
                if  checkConnection == "Not reachable" {
                    
                    print("Internet connection FAILED")
                    
                    if viewController != nil {
                        SharedAlert.alert.displayAlertMessage(viewController: viewController, strMessage: MessageConstant.commonMessage.interConn, buttonTitle: "OK")
                    }
                   SharedClass.sharedInstance.showProgressHUD(false)
                    return
                }
            })
        
        
        
        let strApiName:String = APIName!
        
        let finalURLString:String = strApiName
        
        if HTTPType == "POST" || HTTPType == "PUT" {
            
            CoreWebserviceManager.manager.PostWeb_Service_Body(finalURLString as String, authToken:"", httpMethod: HTTPType! as String, parameters:dictparamters! as [String : AnyObject], completionHandler:{(data : Data?, response : URLResponse?, error :Error?) in
                
                if response != nil {
                    
                    let responseHttp:HTTPURLResponse = response as! HTTPURLResponse
                    
                    if responseHttp.statusCode == 200 {
                        
                        if (data != nil) {
                            
                            do {
                                
                                let JSON = try JSONSerialization.jsonObject(with: data!, options:[]) as! [String : AnyObject]
                                
                                let JSONDictionary:Dictionary<String,AnyObject> = JSON
                                
                                var jsonString = String()
                                jsonString = String(data: data!, encoding: String.Encoding.utf8)!
                                print("======================================================================")
                                print("jsonString\n \(jsonString)")
                                print("======================================================================")
                                
                                if Int(truncating: JSONDictionary[ResponseConstant.statusCode] as! NSNumber) == 200 {
                                    SharedClass.sharedInstance.showProgressHUD(false)
                                    
                                    completion(JSONDictionary)
                                }
                                else {
                                    SharedClass.sharedInstance.showProgressHUD(false)
                                    completion(JSONDictionary)
                                }
                            }
                            catch let JSONError as Error? {
                                print("\(String(describing: JSONError))")
                                
                                SharedClass.sharedInstance.showProgressHUD(false)
                                
                                SharedAlert.alert.displayAlertMessage(viewController: viewController, strMessage: JSONError?.localizedDescription , buttonTitle: "OK")
                                
                            }
                        }
                    }
                    else {
                       SharedClass.sharedInstance.showProgressHUD(false)
                        SharedAlert.alert.displayAlertMessage(viewController: viewController, strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: "OK")
                    }
                }
                else {
                    if (error != nil) {
                        SharedClass.sharedInstance.showProgressHUD(false)
                            SharedAlert.alert.displayAlertMessage(viewController: viewController, strMessage:error?.localizedDescription, buttonTitle: "OK")
                    }
                }
            })
            
        }
        else if HTTPType == "GET" || HTTPType == "DELETE" {
            
            print(finalURLString)
            
            CoreWebserviceManager.manager.GetWeb_Service(finalURLString as String, authToken: "", httpMethod: HTTPType!, completionHandler:{(data : Data?, response : URLResponse?, error :Error?) in
                
                if response != nil {
                    
                    let responseHttp:HTTPURLResponse = response as! HTTPURLResponse
                    
                    if responseHttp.statusCode == 200 {
                        
                        if (data != nil) {
                            do {
                                let JSON = try JSONSerialization.jsonObject(with: data!, options:.allowFragments) as! [[String : Any]]
                                print("JSON! \(JSON)")
                                var outputDict:Dictionary<String,Any> = Dictionary()
                                outputDict["data"] = JSON
                                completion(outputDict as Dictionary<String,AnyObject>)
                            }
                            catch let JSONError as Error? {
                                print("\(String(describing: JSONError))")
                            }
                        }
                        else {
                            SharedAlert.alert.displayAlertMessage(viewController: viewController, strMessage:MessageConstant.validationMessage.OPERATIONAL_ERROR, buttonTitle: "OK")
                        }
                    }
                }
            })
        }
    }
}
