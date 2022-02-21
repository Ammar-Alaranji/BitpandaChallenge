//
//  CommodityListItemViewModel.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/22/22.
//

import Foundation

class CommodityListItemViewModel {
    
    // MARK: - Properties
    var cryptoIcon: URL
    var cryptoSymbol: String
    var name: String
    var formattedBalance: String
    var balance: String
    var isDefault: Bool
    var deleted: Bool
    
    init(commodityWalet: Wallet) {
        
        self.cryptoIcon = URL(fileURLWithPath: "")
        self.cryptoSymbol = commodityWalet.attributes.cryptocoinSymbol
        self.name = commodityWalet.attributes.name
        self.formattedBalance = commodityWalet.attributes.balance.currency(maximumFractionDigits: nil)
        self.balance = commodityWalet.attributes.balance
        self.isDefault = commodityWalet.attributes.isDefault
        self.deleted = commodityWalet.attributes.deleted
    }
}

extension CommodityListItemViewModel: Comparable {
    
    static func > (lhs: CommodityListItemViewModel, rhs: CommodityListItemViewModel) -> Bool {
        return Double(lhs.balance) ?? 0 > Double(rhs.balance) ?? 0
    }
    
    static func < (lhs: CommodityListItemViewModel, rhs: CommodityListItemViewModel) -> Bool {
        return Double(lhs.balance) ?? 0 < Double(rhs.balance) ?? 0
    }
    
    static func == (lhs: CommodityListItemViewModel, rhs: CommodityListItemViewModel) -> Bool {
        return Double(lhs.balance) ?? 0 == Double(rhs.balance) ?? 0
    }
}
