//
//  AssetsListDependencyContainer.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import UIKit
import Foundation

class AssetsListDependencyContainer {
    
    // MARK: - Properties
    let sharedAssetSessionRepository: AssetsRepository
    
    // MARK: - Methods
    init() {
        
        func makeAssetSessionRepository() -> AssetsRepository {
                
            let remoteAssetsAPI = makeRemoteAPI()
            return BitpandaAssetsRepository(remoteAssetsAPI: remoteAssetsAPI)
        }
        
        func makeRemoteAPI() -> RemoteAssetsAPI {
            
            #if ASSETS_SESSION_DATASTORE_LOCALFILE
                return FakeRemoteAssetsAPI()
            #else
                return BitpandaRemoteAssetsAPI()
            #endif
        }
        
        self.sharedAssetSessionRepository = makeAssetSessionRepository()
    }
    
    // MARK: - Factory Methods
    // Create AssetsListViewController
    func makeAssetsListViewController() -> AssetsListViewController {
        
        let assetsListViewModle = self.makeAssetsListViewModel()
        return AssetsListViewController.create(assetListViewModel: assetsListViewModle)
    }
    
    func makeAssetsListViewModel() -> AssetsListViewModel {
        return AssetsListViewModel(assetsRepository: self.sharedAssetSessionRepository)
    }
}
