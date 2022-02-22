//
//  BitpandaAppDependencyContainer.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import UIKit

class BitpandaAppDependencyContainer {
    
    // MARK: - Properties
    var navigationFactory: ((BitpandaMainNavigationViewController) -> Void)?
    
    // MARK: - Methods
    
    // MARK: - Factory Methods
    // Create MainViewController
    func makeMainViewController() -> UIViewController {
        
        let navigation = self.makeMainNavigationViewController()
        let assetsListViewController = self.makeAssetsListViewController()
        let walletsListViewControler = self.makeWalletListViewController()
        
        let mainViewController = MainViewController.create(assetsListViewController: assetsListViewController, walletsListViewControler: walletsListViewControler)
        
        navigation.setViewControllers([mainViewController], animated: false)
        return navigation
    }
    func makeMainNavigationViewController() -> UINavigationController {
                
        return BitpandaMainNavigationViewController.create()
    }
    
    func makeAssetsListViewController() -> UIViewController {
        return AssetsListDependencyContainer().makeAssetsListViewController()
    }
    
    func makeWalletListViewController() -> WalletListViewController {
        return WalletListDependencyContainer().makeWalletListViewController()
    }
}
