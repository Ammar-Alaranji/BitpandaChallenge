//
//  MasterdataDTO+Mapping.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/23/22.
//

import Foundation

struct MasterdataDTO: Codable {
    let data: DataAttributeDTO
}

struct DataAttributeDTO : Codable {
    let type: String
    let attributes: AttributesDTO
}

struct AttributesDTO: Codable {
    enum CodingKeys: String, CodingKey {
        case cryptocoins, commodities, fiats, wallets, fiatwallets
        case commodityWallets = "commodity_wallets"
    }
    let cryptocoins: [AssetDTO]
    let commodities: [AssetDTO]
    let fiats: [AssetDTO]
    let wallets: [WalletDTO]
    let commodityWallets: [WalletDTO]
    let fiatwallets: [FiatWalletDTO]
}

extension MasterdataDTO {
    func toDomain() -> Masterdata {
        return .init(data: data.toDomain())
    }
}

extension DataAttributeDTO {
    func toDomain() -> DataAttribute {
        return .init(type: type, attributes: attributes.toDomain())
    }
}

extension AttributesDTO {
    func toDomain() -> Attributes {
        return .init(cryptocoins: cryptocoins.map { $0.toDomain()},
                     commodities: commodities.map { $0.toDomain()},
                     fiats: fiats.map { $0.toDomain()},
                     wallets: wallets.map { $0.toDomain()},
                     commodityWallets: commodityWallets.map { $0.toDomain()},
                     fiatwallets: fiatwallets.map { $0.toDomain()})
    }
}

