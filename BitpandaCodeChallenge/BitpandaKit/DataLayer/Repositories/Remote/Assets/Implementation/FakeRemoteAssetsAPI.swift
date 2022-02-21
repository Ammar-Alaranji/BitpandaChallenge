//
//  FakeRemoteAssetsAPI.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import Promises

struct FakeRemoteAssetsAPI: RemoteAssetsAPI {
    func fetchAssets() -> Promise<Attributes> {
        return Promise<Attributes>(on: .global()) { fulfill, reject in
            
            // Read data from the Masterdata.json file
            do {
                if let bundlePath = Bundle.main.path(forResource: "Masterdata",
                                                     ofType: "json"),
                   let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
                    let masterdata = try JSONDecoder().decode(Masterdata.self, from: jsonData)
                    fulfill(masterdata.data.attributes)
                }
            } catch {
                return reject(error)
            }
        }
    }
}
