//
//  BitpandaRemoteWalletsAPI.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation
import Promises

// TODO: - Implement the real application connection functionality

// Add the methodes to get the data from the Bitpanda cloud service APIs
class BitpandaRemoteWalletsAPI: RemoteWalletsAPI {
    func fetchWallets() -> Promise<Wallets> {
        return Promise<Wallets> { fulfill, reject in
            
            reject(BitpandaKitError.remoteAPINotAvailalbe)
        }
    }
}
