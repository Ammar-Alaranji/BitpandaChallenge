//
//  AppDelegate.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/19/22.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let bitpandaAppDependencyContainer = BitpandaAppDependencyContainer()
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
//        let injectionContainer = AssetsListDependencyContainer(bitpandaNavigation: bitpandaAppDependencyContainer)
//        let mainVC = injectionContainer.makeAssetsListViewController()
        
        let injectionContainer = WalletListDependencyContainer(bitpandaNavigation: bitpandaAppDependencyContainer)
        let mainVC = injectionContainer.makeWalletListViewController()

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = mainVC
        return true
    }
}

