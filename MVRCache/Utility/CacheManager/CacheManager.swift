//
//  CacheManager.swift
//  MVRCache
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import UIKit

/*
 * This enum is for Type of Cache Object
 */
public enum CacheType:Int {
    case Image = 0
    case JSON  = 1
    case Zip   = 2
}

/*
 * SingleTon class for Cache handling
 */
open class CacheManager {
    
   public static let manage:CacheManager = {
        let instance = CacheManager()
        return instance
    }()
    
    var currentCache:PurgeCache?
    typealias JSON = [String : Any]

    
    private init() {
        
    }
  
    
    /*
     * This method will setup initial cache configurations
     */
   public func initWithNameSpace(specifiedSpace:String,shouldEvict:Bool,delegate:UIViewController) {
        
        let nameSpace = "com.mv.MVRCache" + specifiedSpace
        currentCache = PurgeCache()
        currentCache?.name = nameSpace
        currentCache?.evictsObjectsWithDiscardedContent = shouldEvict
        currentCache?.delegate = delegate as? NSCacheDelegate
        self.setMaxCostLimit(cost: 100*1024*1024)
        self.setMaxCountLimit(count: 100)
        NotificationCenter.default.addObserver(forName: UIApplication.didReceiveMemoryWarningNotification, object: nil, queue: .main) { [] notification in
            self.currentCache?.removeAllObjects()
        }
    }
   
    /*
     * This method will setup Maximum Cost Limt
     */
   public func setMaxCostLimit(cost:Int) {
        currentCache?.totalCostLimit = cost
    }
    
    /*
     * This method will setup Maximum Count Limt
     */
   public func setMaxCountLimit(count:Int) {
        currentCache?.countLimit = count
    }
    
    
    /*
     * This method will convert passed object to Cache and store it
     */
    func setObjectToCache(currentObject:AnyObject,key:String,objectType:CacheType){
        var cost:UInt
        switch objectType {
        case .Image:
            let imageObject = currentObject as! UIImage
            cost = UInt(imageObject.size.height * imageObject.size.width * imageObject.scale * imageObject.scale)
            break
        default:
            cost = UInt(self.heapSize(currentObject))
            break
        }
        self.currentCache?.setObject(currentObject, forKey: key as AnyObject, cost: Int(cost))
        
    }
    
    /*
     * This method will get heapSize of object
     */
    func heapSize(_ obj: AnyObject) -> Int {
        return malloc_size(Unmanaged.passRetained(obj).toOpaque())
    }
    
    
    /*
     * This method will get UIImage or other object from cache if it already in cache. Else it will download image from Server.
     */
   public func cacheResponseFromURL(sourceURL:String?,shouldStoreInCache:Bool,cacheType:CacheType,completion: @escaping (_ cacheObject:AnyObject?,_ error:Error?,_ cacheType:CacheType) -> Void) {
        
        let objResponse = self.currentCache?.object(forKey: sourceURL as AnyObject)
        if objResponse == nil {
            let url:URL = URL(string: sourceURL!)!
            self.downloadData(url:url) { data, response, error in
                switch cacheType {
                case .Image:
                    if let data = data, let image = UIImage(data: data) {
                        self.setObjectToCache(currentObject: image, key: sourceURL!, objectType:.Image)
                        completion(image,error,.Image)
                    }
                    else {
                        completion(UIImage(named: UIConstant.Images.placeHolderImage),error!,.Image)
                    }
                    break
                case .JSON:
                    if let data = data, let responseObject = self.convertToJSON(with: data) {
                        self.setObjectToCache(currentObject: responseObject as AnyObject, key: sourceURL!, objectType:.JSON)
                        completion(responseObject as AnyObject,error!,.JSON)
                    }
                    else {
                        completion(nil,error,.JSON)
                    }
                    break
                case .Zip:
                    completion(data as AnyObject?,error,.Zip)
                    break
                }
            }
        }
        else {
            completion(objResponse,nil,cacheType)
        }
    }
    
    /*
     * This method will download data from URL
     */
    func downloadData(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession(configuration: .ephemeral).dataTask(with: URLRequest(url: url)) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    /*
     * This method will convert data to JSON
     */
   func convertToJSON(with data: Data) -> JSON? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSON
        } catch {
            return nil
        }
    }
    
    /*
     * This method will clear memory cache
     */
    public func clearMemoryCache() {
        self.currentCache?.removeAllObjects()
    }
    
    /*
     * This method will remove observer
     */
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}


class PurgeCache:NSCache<AnyObject, AnyObject> {
    
}
