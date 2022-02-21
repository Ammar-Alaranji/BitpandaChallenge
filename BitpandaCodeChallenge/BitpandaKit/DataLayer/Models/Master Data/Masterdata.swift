//
//  Masterdata.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation

struct Masterdata: Codable {
    let data: DataAttribute
}

struct DataAttribute : Codable {
    let type: String
    let attributes: Attributes
}

struct Attributes: Codable {
    enum CodingKeys: String, CodingKey {
        case cryptocoins, commodities, fiats, wallets, fiatwallets
        case commodityWallets = "commodity_wallets"
    }
    let cryptocoins: [Asset]
    let commodities: [Asset]
    let fiats: [Asset]
    let wallets: [Wallet]
    let commodityWallets: [Wallet]
    let fiatwallets: [FiatWallet]
}
