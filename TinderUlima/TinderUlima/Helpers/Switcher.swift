//
//  Switcher.swift
//  TinderUlima
//
//  Created by Eros Campos on 17/07/18.
//  Copyright © 2018 Eros Campos. All rights reserved.
//
// Codigo obtenido de https://medium.com/@paul.allies/ios-swift4-login-logout-branching-4cdbc1f51e2c

import Foundation
import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        let status = UserDefaults.standard.bool(forKey: "status")
        var rootVC : UIViewController?
        
        print(status)
        
        if(status == true){
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "HomeNavController") as! UINavigationController
        }else{
            rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        }
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
