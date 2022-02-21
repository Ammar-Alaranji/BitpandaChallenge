//
//  RemoteAssetsAPI.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import Promises

protocol RemoteAssetsAPI {
    func fetchAssets() -> Promise<Attributes>
}
