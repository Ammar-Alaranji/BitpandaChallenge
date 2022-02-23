//
//  StringExtension.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation

extension String {
    
    func currency(maximumFractionDigits: Int?) -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = maximumFractionDigits ?? 2
        
        // localize to your grouping and decimal separator
        currencyFormatter.locale = Locale.current
        
        // We'll force unwrap with the !, if you've got defined data you may need more error checking
        if let averagePriceDouble = Double(self) {
            let number = NSNumber(value: averagePriceDouble)
            let priceString = currencyFormatter.string(from: number)!
            return priceString
        }
        return self
    }
}
