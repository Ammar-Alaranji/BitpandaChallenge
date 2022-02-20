//
//  AppDelegate.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/19/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let injectionContainer = AssetsListDependencyContainer()
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let mainVC = injectionContainer.makeAssetsListViewController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainVC
        return true
    }
}

