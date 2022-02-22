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
    private let sharedAssetSessionRepository: AssetsRepository
    
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
    func makeAssetsListViewController() -> UIViewController {
        
        let assetsListViewModle = self.makeAssetsListViewModel()
        let navigation = self.makeMainNavigationViewController()
        let assetsListViewController = AssetsListViewController.create(assetListViewModel: assetsListViewModle)
        
        navigation.setViewControllers([assetsListViewController], animated: false)
        return navigation
    }
    
    private func makeAssetsListViewModel() -> AssetsListViewModel {
        return AssetsListViewModel(assetsRepository: self.sharedAssetSessionRepository)
    }
    
    func makeMainNavigationViewController() -> UINavigationController {
        return BitpandaAppDependencyContainer().makeMainNavigationViewController()
    }
}
