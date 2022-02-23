//
//  WalletsDTO+Mapping.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/23/22.
//

import Foundation

struct WalletsDTO {
    let fiatWallets: [FiatWalletDTO]
    let commodityWallets: [WalletDTO]
    
    init(fiatWallets: [FiatWalletDTO], commodityWallets: [WalletDTO]) {
        self.fiatWallets = fiatWallets
        self.commodityWallets = commodityWallets
    }
    
    init() {
        self.fiatWallets = []
        self.commodityWallets = []
    }
}
