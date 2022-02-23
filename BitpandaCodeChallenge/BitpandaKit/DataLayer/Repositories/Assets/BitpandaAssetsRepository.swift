//
//  BitpandaAssetsRepository.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/19/22.
//

import Foundation
import Promises

final class BitpandaAssetsRepository: AssetsRepository {
    
    // MARK: - Repositories
    private let remoteAssetsAPI: RemoteAssetsAPI
    
    // MARK: - Initilaizer
    init(remoteAssetsAPI: RemoteAssetsAPI) {
        self.remoteAssetsAPI = remoteAssetsAPI
    }
    
    // MARK: - Implementaion
    func fetchAssets() -> Promise<[Asset]> {
        return self.remoteAssetsAPI.fetchAssets()
    }
}
