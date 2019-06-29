//
//  SharedClass.swift
//  MVRCache
//
//  Created by Admin on 25/06/19.
//  Copyright © 2019 Admin. All rights reserved.
//

import Foundation
import Reachability
import SVProgressHUD

 // SingleTon class for app usage
class SharedClass:NSObject {
    
    static let sharedInstance : SharedClass = {
        let instance = SharedClass()
        return instance
    }()
    
    
    // MARK:- UIColor Modification methods
    
    func colorWithHexStringAndAlpha(_ hexString: String, alpha:CGFloat) -> UIColor {
        
        // Convert hex string to an integer
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha
        
        // Create color object, specifying alpha as well
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        // Create scanner
        let scanner: Scanner = Scanner(string: hexStr)
        // Tell scanner to skip the # character
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#")
        // Scan hex value
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
    
    
    
    // MARK:- ProgressHUD methods
    
    func showProgressHUD(_ isShow:Bool) {
        
        if isShow == true {
            
            if (!SVProgressHUD.isVisible()) {
                SVProgressHUD.setBackgroundColor(self.colorWithHexStringAndAlpha(UIConstant.ProgressHUD.bgColor, alpha: 1.0))
                SVProgressHUD.setForegroundColor(self.colorWithHexStringAndAlpha(UIConstant.ProgressHUD.TextColor, alpha: 1.0))
                SVProgressHUD.setDefaultStyle(.custom)
                SVProgressHUD.setDefaultMaskType(.black)
                SVProgressHUD.show()
            }
        }
        else {
            SVProgressHUD.dismiss()
        }
    }
    
    // MARK:- Reachability methods
    
    func hasConnectivity(completion: @escaping (_ interConnected:String) -> Void) {
        
        let reachability = Reachability()!
        
        reachability.whenReachable = { reachability in
            
            DispatchQueue.main.async {
                if reachability.connection == .wifi {
                    print("Reachable via WiFi")
                    completion("Reachable via WiFi")
                    
                } else {
                    print("Reachable via Cellular")
                    completion("Reachable via Cellular")
                }
            }
        }
        
        reachability.whenUnreachable = { reachability in
            
            DispatchQueue.main.async {
                print("Not reachable")
                completion("Not reachable")
            }
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
}
