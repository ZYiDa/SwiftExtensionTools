//
//  AppDelegate.swift
//  SwiftExtensionTools
//
//  Created by zhoucz on 2021/07/26.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    public var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
        
        let vc = ViewController()
        vc.navigationItem.title = "SwiftExtensionTools"
        
        self.window?.rootViewController = BaseNavigationController(rootViewController:vc )
        
        return true
    }

}

