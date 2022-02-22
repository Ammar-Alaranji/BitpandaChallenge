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
    
    // MARK: - Methods
    init() {
        
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
        
        self.sharedWalletsSessionRepository = makeWalletsSessionRepository()
    }

    // MARK: - Factory Methods
    // Create WalletListViewController
    func makeWalletListViewController() -> WalletListViewController {
        
        let walletsViewModel = self.makeWalletsListViewModel()
        let walletListViewController = WalletListViewController.create(walletsListViewModel: walletsViewModel)
        
        return walletListViewController
    }
    
    private func makeWalletsListViewModel() -> WalletsListViewModel {
        return WalletsListViewModel(walletsRepository: self.sharedWalletsSessionRepository)
    }
}
