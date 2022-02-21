//
//  FiatListItemViewModel.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/22/22.
//

import Foundation

class FiatListItemViewModel {
    
    // MARK: - Properties
    var fiatIcon: URL
    var fiatSymbol: String
    var name: String
    var formattedBalance: String
    var balance: String
    
    init(fiatWalet: FiatWallet) {
        
        self.fiatIcon = URL(fileURLWithPath: "")
        self.fiatSymbol = fiatWalet.attributes.fiatSymbol
        self.name = fiatWalet.attributes.name
        self.formattedBalance = fiatWalet.attributes.balance.currency(maximumFractionDigits: nil)
        self.balance = fiatWalet.attributes.balance
    }
}

extension FiatListItemViewModel: Comparable {
    static func == (lhs: FiatListItemViewModel, rhs: FiatListItemViewModel) -> Bool {
        return Double(lhs.balance) ?? 0 == Double(rhs.balance) ?? 0
    }
    
    static func < (lhs: FiatListItemViewModel, rhs: FiatListItemViewModel) -> Bool {
        return Double(lhs.balance) ?? 0 < Double(rhs.balance) ?? 0
    }
    
    static func > (lhs: FiatListItemViewModel, rhs: FiatListItemViewModel) -> Bool {
        return  Double(lhs.balance) ?? 0 > Double(rhs.balance) ?? 0
    }
}
