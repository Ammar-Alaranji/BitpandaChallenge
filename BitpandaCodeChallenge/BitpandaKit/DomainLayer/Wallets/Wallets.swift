//
//  GroupedWallets.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation

struct Wallets {
    let fiatWallets: [FiatWallet]
    let commodityWallets: [Wallet]
    
    init(fiatWallets: [FiatWallet], commodityWallets: [Wallet]) {
        self.fiatWallets = fiatWallets
        self.commodityWallets = commodityWallets
    }
    
    init() {
        self.fiatWallets = []
        self.commodityWallets = []
    }
}
