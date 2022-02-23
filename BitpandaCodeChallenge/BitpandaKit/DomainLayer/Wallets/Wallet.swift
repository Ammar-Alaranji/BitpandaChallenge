//
//  Wallet.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation

struct Wallet {
    typealias Identifier = String
    enum WalletType: String {
        case wallet
        case fiatWallet = "fiat_wallet"
    }

    let type: WalletType
    let id: Identifier
    let attributes: WalletAttribute
}

struct WalletAttribute: Codable {
    let name: String
    let balance: String
    let cryptocoinId: String
    let cryptocoinSymbol: String
    let isDefault: Bool
    let deleted: Bool
}
