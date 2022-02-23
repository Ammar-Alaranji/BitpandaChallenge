//
//  FakeRemoteWalletsAPI.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation
import Promises

class FakeRemoteWalletsAPI: RemoteWalletsAPI {
    
    func fetchWallets() -> Promise<Wallets> {
        
        let promise = Promise<Wallets>(on: .global(), { fulfill, reject in
            // Read data from the Masterdata.json file
            do {
                if let bundlePath = Bundle.main.path(forResource: "Masterdata",
                                                     ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let masterdata = try JSONDecoder().decode(MasterdataDTO.self, from: jsonData)
                    
                    // Declare a new Wallet object
                    // Fill Wallets with returned data from the masterdata ogject
                    let wallets = Wallets(fiatWallets: masterdata.data.attributes.toDomain().fiatwallets,
                                          commodityWallets: masterdata.data.attributes.toDomain().wallets + masterdata.data.attributes.toDomain().commodityWallets)
                    fulfill(wallets)
                }
            } catch {
                return reject(error)
            }
            
        })
        return promise
    }
}
