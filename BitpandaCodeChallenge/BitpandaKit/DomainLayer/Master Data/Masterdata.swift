//
//  Masterdata.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation

struct Masterdata {
    let data: DataAttribute
}

struct DataAttribute {
    let type: String
    let attributes: Attributes
}

struct Attributes {
    let cryptocoins: [Asset]
    let commodities: [Asset]
    let fiats: [Asset]
    let wallets: [Wallet]
    let commodityWallets: [Wallet]
    let fiatwallets: [FiatWallet]
}
