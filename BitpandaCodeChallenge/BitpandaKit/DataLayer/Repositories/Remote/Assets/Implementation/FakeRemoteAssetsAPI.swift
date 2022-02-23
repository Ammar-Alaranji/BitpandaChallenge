//
//  FakeRemoteAssetsAPI.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import Promises

struct FakeRemoteAssetsAPI: RemoteAssetsAPI {
    func fetchAssets() -> Promise<[Asset]> {
        return Promise<[Asset]>(on: .global()) { fulfill, reject in
            
            // Read data from the Masterdata.json file
            do {
                if let bundlePath = Bundle.main.path(forResource: "Masterdata",
                                                     ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let masterdata = try JSONDecoder().decode(MasterdataDTO.self, from: jsonData)
                    
                    fulfill(masterdata.data.attributes.toDomain().commodities + masterdata.data.attributes.toDomain().cryptocoins + masterdata.data.attributes.toDomain().fiats)
                }
            } catch {
                return reject(error)
            }
        }
    }
}
