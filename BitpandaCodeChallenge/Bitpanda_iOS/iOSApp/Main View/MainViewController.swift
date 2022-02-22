//
//  MainViewController.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/22/22.
//

import UIKit

class MainViewController: UITabBarController {
    
    // MARK: - Child View Controllers
    var assetsListViewController: UIViewController?
    var walletsListViewControler: WalletListViewController?
        
    // MARK: - Factory method
    static func create(assetsListViewController: UIViewController, walletsListViewControler: WalletListViewController) -> UIViewController {
        
        // Create instance from AssetsListViewController
        let viewController = MainViewController.init(nibName: MainViewController.defaultFileName, bundle: nil)
        
        // Assign assetListViewModel value
        viewController.assetsListViewController = assetsListViewController
        viewController.walletsListViewControler = walletsListViewControler
        
        return viewController
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupViews()
    }
    
    // MARK: - Private
    private func setupViews() {
        if let assetController = self.assetsListViewController,
           let walletController = self.walletsListViewControler {
            // Setup asset tab bar item
            assetController.tabBarItem.title = NSLocalizedString("Assets", comment: "Asset tab bar item title")
            assetController.tabBarItem.image = UIImage(named: "placeHolder")
            
            walletController.tabBarItem.title = NSLocalizedString("Wallets", comment: "Wallets tab bar item title")
            walletController.tabBarItem.image = UIImage(named: "fiatWallet")
            
            self.viewControllers = [assetController, walletController]
            self.selectedIndex = 0
        }
    }
}
