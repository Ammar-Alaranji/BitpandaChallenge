//
//  AssetDTO+Mapping.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/23/22.
//

import Foundation

struct AssetDTO: Codable {
    typealias Identifier = String
    enum AssetTypeDTO: String, Codable {
        case cryptocoin
        case commodity
        case fiat
    }

    let type: AssetTypeDTO
    let id: Identifier
    let attributes: AssetAttributesDTO
}

struct AssetAttributesDTO: Codable {
    private enum CodingKeys: String, CodingKey {
        case symbol, name
        case icon = "logo"
        case iconDark = "logo_dark"
        case hasWalet = "has_wallets"
        case averagePrice = "avg_price"
        case percesionForFiatPrice = "precision_for_fiat_price"
    }
    
    let symbol: String
    let name: String
    let icon: URL
    let iconDark: URL
    let hasWalet: Bool?
    let averagePrice: String?
    let percesionForFiatPrice: Int?
}

extension AssetDTO {
    func toDomain() -> Asset {
        return Asset(type: type.toDomain(), id: id, attributes: attributes.toDomain())
    }
}

extension AssetDTO.AssetTypeDTO {
    func toDomain() -> Asset.AssetType {
        switch self {
            
        case .cryptocoin:
            return .cryptocoin
        case .commodity:
            return .commodity
        case .fiat:
            return .fiat
        }
    }
}

extension AssetAttributesDTO {
    func toDomain() -> AssetAttributes {
        return .init(symbol: symbol, name: name, icon: icon, iconDark: iconDark, hasWalet: hasWalet, averagePrice: averagePrice, percesionForFiatPrice: percesionForFiatPrice)
    }
}
