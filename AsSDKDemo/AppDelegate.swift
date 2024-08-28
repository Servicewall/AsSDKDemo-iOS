//
//  AppDelegate.swift
//  AsSDKDemo
//
//  Created by Carl Chen on 2024/4/19.
//

import UIKit
import SwSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SwSDKManager.shared().registerURLProtocol()
        return true
    }

   


}

