//
//  WalletListDependencyContainer.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import UIKit

class WalletListDependencyContainer {
    
    // MARK: - Properties
    private let sharedWalletsSessionRepository: WalletsRepository
    private let bitpandaNavigation: BitpandaNavigation
    
    // MARK: - Methods
    init(bitpandaNavigation: BitpandaNavigation) {
        
        func makeWalletsSessionRepository() -> WalletsRepository {
                
            let remoteWalletsAPI = makeRemoteAPI()
            return BitpandaWalletsRepository(remoteWalletsAPI: remoteWalletsAPI)
        }
        
        func makeRemoteAPI() -> RemoteWalletsAPI {
            
            #if ASSETS_SESSION_DATASTORE_LOCALFILE
                return FakeRemoteWalletsAPI()
            #else
                return BitpandaRemoteWalletsAPI()
            #endif
        }
        
        self.bitpandaNavigation = bitpandaNavigation
        self.sharedWalletsSessionRepository = makeWalletsSessionRepository()
    }

    // MARK: - Factory Methods
    // Create WalletListViewController
    func makeWalletListViewController() -> UIViewController {
        
        let walletsViewModel = self.makeWalletsListViewModel()
        let navigation = self.bitpandaNavigation.makeMainNavigationViewController()
        let walletListViewController = WalletListViewController.create(walletsListViewModel: walletsViewModel)
        
        navigation.setViewControllers([walletListViewController], animated: false)
        return navigation
    }
    
    private func makeWalletsListViewModel() -> WalletsListViewModel {
        return WalletsListViewModel(walletsRepository: self.sharedWalletsSessionRepository)
    }
}
