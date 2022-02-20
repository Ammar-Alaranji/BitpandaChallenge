//
//  AppDelegate.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/19/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let AppDependencyContainer = BitpandaAppDependencyContainer()
        let result = AppDependencyContainer.sharedAssetSessionRepository.fetchAssets()
        result.catch(on: .main) { error in
            let errorMessage = (error as? BitpandaKitError)?.description
            print(errorMessage ?? "")
        }.then(on: .main) { resultAttributes in
            print(resultAttributes)
        }
        
        return true
    }
}

