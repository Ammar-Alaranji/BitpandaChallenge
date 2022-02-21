//
//  FiatWallet.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation

import Foundation

struct FiatWallet: Codable {
    typealias Identifier = String
    enum FiatWalletType: String, Codable {
        case wallet
        case fiatWallet = "fiat_wallet"
    }

    let type: FiatWalletType
    let id: Identifier
    let attributes: FiatWalletAttribute
}

struct FiatWalletAttribute: Codable {
    private enum CodingKeys: String, CodingKey {
        case name, balance
        case fiatId = "fiat_id"
        case fiatSymbol = "fiat_symbol"
    }

    let name: String
    let balance: String
    let fiatId: String
    let fiatSymbol: String
}
