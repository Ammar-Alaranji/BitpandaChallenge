//
//  WalletDTO+Mapping.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/23/22.
//

import Foundation
import SwiftUI

struct WalletDTO: Codable {
    typealias Identifier = String
    enum WalletTypeDTO: String, Codable {
        case wallet
        case fiatWallet = "fiat_wallet"
    }

    let type: WalletTypeDTO
    let id: Identifier
    let attributes: WalletAttributeDTO
}

struct WalletAttributeDTO: Codable {
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

extension WalletDTO {
    func toDomain() -> Wallet {
        return .init(type: type.toDomain(), id: id, attributes: attributes.toDomain())
    }
}

extension WalletDTO.WalletTypeDTO {
    func toDomain() -> Wallet.WalletType {
        switch self {case .wallet:
            return .wallet
        case .fiatWallet:
            return .fiatWallet
        }
    }
}

extension WalletAttributeDTO {
    func toDomain() -> WalletAttribute {
        return .init(name: name, balance: balance, cryptocoinId: cryptocoinId, cryptocoinSymbol: cryptocoinSymbol, isDefault: isDefault, deleted: deleted)
    }
}
