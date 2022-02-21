//
//  AssetListItemViewModel.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation

class AssetListItemViewModel {
    
    // MARK: - Properties
    var icon: URL
    var name: String
    var avergePrice: String
    var type: Asset.AssetType
    
    // MARK: - Publishers
    @Published public private(set) var averagePriceIsHidden = false
    
    init(asset: Asset) {
        self.type = asset.type
        self.icon = asset.attributes.icon
        self.name = asset.attributes.name + " - " + asset.attributes.symbol
        
        let showPrice = asset.type == .commodity || asset.type == .cryptocoin
        if showPrice {
            self.averagePriceIsHidden = false
            let formattedAveragePrice = asset.attributes.averagePrice?.currency(maximumFractionDigits: asset.attributes.percesionForFiatPrice)
            self.avergePrice = formattedAveragePrice ?? ""
        } else {
            self.avergePrice = ""
            self.averagePriceIsHidden = true
        }
    }
}
