//
//  FiatWallet.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation

struct FiatWallet {
    typealias Identifier = String
    enum FiatWalletType: String {
        case wallet
        case fiatWallet = "fiat_wallet"
    }

    let type: FiatWalletType
    let id: Identifier
    let attributes: FiatWalletAttribute
}

struct FiatWalletAttribute {
    let name: String
    let balance: String
    let fiatId: String
    let fiatSymbol: String
}
