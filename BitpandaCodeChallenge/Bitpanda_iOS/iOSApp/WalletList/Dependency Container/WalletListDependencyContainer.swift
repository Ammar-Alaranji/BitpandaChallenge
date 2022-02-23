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
    private let sharedAssetSessionRepository: AssetsRepository
    
    // MARK: - Methods
    init() {
        
        func makeWalletsSessionRepository() -> WalletsRepository {
                
            let remoteWalletsAPI = makeWalletRemoteAPI()
            return BitpandaWalletsRepository(remoteWalletsAPI: remoteWalletsAPI)
        }
        
        func makeWalletRemoteAPI() -> RemoteWalletsAPI {
            
            #if ASSETS_SESSION_DATASTORE_LOCALFILE
                return FakeRemoteWalletsAPI()
            #else
                return BitpandaRemoteWalletsAPI()
            #endif
        }
        
        func makeAssetSessionRepository() -> AssetsRepository {
                
            let remoteAssetsAPI = makeRemoteAssetAPI()
            return BitpandaAssetsRepository(remoteAssetsAPI: remoteAssetsAPI)
        }
        
        func makeRemoteAssetAPI() -> RemoteAssetsAPI {
            
            #if ASSETS_SESSION_DATASTORE_LOCALFILE
                return FakeRemoteAssetsAPI()
            #else
                return BitpandaRemoteAssetsAPI()
            #endif
        }
        
        self.sharedAssetSessionRepository = makeAssetSessionRepository()
        
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
        return WalletsListViewModel(walletsRepository: self.sharedWalletsSessionRepository, assetRepository: self.sharedAssetSessionRepository)
    }
}
