//
//  WalletsRepository.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation
import Promises

protocol WalletsRepository {
    func getWallets() -> Promise<Wallets>
}
