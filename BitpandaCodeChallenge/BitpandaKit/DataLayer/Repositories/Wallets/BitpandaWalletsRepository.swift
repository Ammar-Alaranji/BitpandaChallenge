//
//  BitpandaWalletsRepository.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation
import Promises

class BitpandaWalletsRepository: WalletsRepository {
    
    // MARK: - Properties
    let remoteWalletsAPI: RemoteWalletsAPI
    
    // MARK: - Initializer
    init(remoteWalletsAPI: RemoteWalletsAPI) {
        self.remoteWalletsAPI = remoteWalletsAPI
    }
    
    func getWallets() -> Promise<Wallets> {
        return self.remoteWalletsAPI.fetchWallets()
    }
}
