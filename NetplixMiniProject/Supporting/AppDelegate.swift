//
//  AppDelegate.swift
//  NetplixMiniProject
//
//  Created by Ferry Julian on 22/08/23.
//

import UIKit
import netfox

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeViewController())
        
        window?.makeKeyAndVisible()
        
        NFX.sharedInstance().start()
        
        return true
    }
    
}
