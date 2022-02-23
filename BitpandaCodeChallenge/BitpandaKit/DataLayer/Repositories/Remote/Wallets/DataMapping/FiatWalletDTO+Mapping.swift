//
//  FiatWalletDTO+Mapping.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/23/22.
//

import Foundation

struct FiatWalletDTO: Codable {
    typealias Identifier = String
    enum FiatWalletTypeDTO: String, Codable {
        case wallet
        case fiatWallet = "fiat_wallet"
    }

    let type: FiatWalletTypeDTO
    let id: Identifier
    let attributes: FiatWalletAttributeDTO
}

struct FiatWalletAttributeDTO: Codable {
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

extension FiatWalletDTO {
    func toDomain() -> FiatWallet {
        return .init(type: type.toDomain(), id: id, attributes: attributes.toDomain())
    }
}

extension FiatWalletDTO.FiatWalletTypeDTO {
    func toDomain() -> FiatWallet.FiatWalletType {
        switch self {case .wallet:
            return .wallet
        case .fiatWallet:
            return .fiatWallet
        }
    }
}
 
extension FiatWalletAttributeDTO {
    func toDomain() -> FiatWalletAttribute {
        return .init(name: name, balance: balance, fiatId: fiatId, fiatSymbol: fiatSymbol)
    }
}
