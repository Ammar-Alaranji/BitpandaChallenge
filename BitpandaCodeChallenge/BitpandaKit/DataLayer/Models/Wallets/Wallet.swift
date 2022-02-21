//
//  Wallet.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation

struct Wallet: Codable {
    typealias Identifier = String
    enum WalletType: String, Codable {
        case wallet
        case fiatWallet = "fiat_wallet"
    }

    let type: WalletType
    let id: Identifier
    let attributes: WalletAttribute
}

struct WalletAttribute: Codable {
    private enum CodingKeys: String, CodingKey {
        case name, balance, deleted
        case cryptocoinId = "cryptocoin_id"
        case cryptocoinSymbol = "cryptocoin_symbol"
        case isDefault = "is_default"
    }

    let name: String
    let balance: String
    let cryptocoinId: String
    let cryptocoinSymbol: String
    let isDefault: Bool
    let deleted: Bool
}
