//
//  Asset.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/19/22.
//

import Foundation

struct Asset: Codable {
    typealias Identifier = String
    enum AssetType: String, Codable {
        case cryptocoin
        case commodity
        case fiat
    }

    let type: AssetType
    let id: Identifier
    let attributes: AssetAttributes
}

struct AssetAttributes: Codable {

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
