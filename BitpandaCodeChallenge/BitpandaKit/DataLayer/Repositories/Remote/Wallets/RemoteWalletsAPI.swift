//
//  RemoteWalletsAPI.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation
import Promises

protocol RemoteWalletsAPI {
    
    func fetchWallets() -> Promise<Wallets>
}
