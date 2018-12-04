//
//  AppDelegate.swift
//  Rainbow
//
//  Created by Shawn on 29/11/2018.
//  Copyright © 2018 Shawn. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let homeController = CameraController() as UIViewController
        
        window?.rootViewController = homeController
        
        return true
    }

    

}

