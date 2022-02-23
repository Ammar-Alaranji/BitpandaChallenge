//
//  Asset.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/19/22.
//

import Foundation

struct Asset {
    typealias Identifier = String
    enum AssetType: String {
        case cryptocoin
        case commodity
        case fiat
    }

    let type: AssetType
    let id: Identifier
    let attributes: AssetAttributes
}

struct AssetAttributes {

    let symbol: String
    let name: String
    let icon: URL
    let iconDark: URL
    let hasWalet: Bool?
    let averagePrice: String?
    let percesionForFiatPrice: Int?
}
