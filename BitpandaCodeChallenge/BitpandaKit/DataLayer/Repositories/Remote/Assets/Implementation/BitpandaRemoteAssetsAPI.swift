//
//  BitpandaRemoteAssetsAPI.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import Promises

// TODO: - Implement the real application connection functionality

// Add the methodes to get the data from the Bitpanda cloud service APIs
class BitpandaRemoteAssetsAPI: RemoteAssetsAPI {
    func fetchAssets() -> Promise<Attributes> {
        return Promise<Attributes>{ fulfill, reject in
            
            reject(BitpandaKitError.remoteAPINotAvailalbe)
        }
    }
}
