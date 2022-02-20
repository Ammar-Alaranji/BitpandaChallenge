//
//  BitpandaAppDependencyContainer.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation

class BitpandaAppDependencyContainer {
    
    // MARK: - Properties
    let sharedAssetSessionRepository: AssetsRepository
    
    // MARK: - Methods
    init() {
        let remoteAssetsAPI = makeRemoteAPI()
        self.sharedAssetSessionRepository = BitpandaAssetsRepository(remoteAssetsAPI: remoteAssetsAPI)
        
        func makeRemoteAPI() -> RemoteAssetsAPI {
            
            #if ASSETS_SESSION_DATASTORE_LOCALFILE
                return FakeRemoteAssetsAPI()
            #else
                return BitpandaRemoteAssetsAPI()
            #endif
        }
    }
    
    // MARK: - Factory Methods
}
