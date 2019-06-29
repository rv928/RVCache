//
//  UserManager.swift
//  MVRCache
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

 // Singleton for User List webservices

class UserManager {
    
    static let manage:UserManager = {
        let instance = UserManager()
        return instance
    }()
    
    /*
     * This method will fetch users from webservice 
     */
    func fetchUsers(vc:UIViewController?,completion: @escaping (_ userList:[UserList]?) -> Void) {
        
        SharedClass.sharedInstance.showProgressHUD(true)
        
        RequestManager.manager.fetchData(vc,dictparamters:nil, APIName: k_APIHost + k_APIUserList,HTTPType:"GET",completion: { (responseDictionary:Dictionary<String,Any>?) -> Void in
            
           // print("userlist response \(responseDictionary)")
            SharedClass.sharedInstance.showProgressHUD(false)
            var objUserList:[UserList]?
            if responseDictionary?["data"] != nil {
                let currentUserList = try! DictionaryDecoder().decode([UserList].self, from: responseDictionary!["data"]!)
                objUserList = currentUserList
                completion(objUserList)
            }
            else {
                DispatchQueue.main.async {
                    SharedAlert.alert.displayAlertMessage(viewController: vc, strMessage: MessageConstant.validationMessage.NO_CONTENT, buttonTitle: "OK")

                }
                completion(nil)
            }
        })
    }
}
