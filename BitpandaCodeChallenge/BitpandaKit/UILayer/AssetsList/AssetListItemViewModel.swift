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
    
    // MARK: - Publishers
    @Published public private(set) var averagePriceIsHidden = false
    
    init(asset: Asset) {
        self.icon = asset.attributes.icon
        self.name = asset.attributes.name + " - " + asset.attributes.symbol
        
        let showPriceFiat = asset.type == .commodity || asset.type == .cryptocoin
        if showPriceFiat {
            self.averagePriceIsHidden = false
            self.avergePrice = String(format: "\(asset.attributes.averagePrice ?? "") %@", showPriceFiat ? "Euro" : "")
        } else {
            self.avergePrice = ""
            self.averagePriceIsHidden = true
        }
    }
}
