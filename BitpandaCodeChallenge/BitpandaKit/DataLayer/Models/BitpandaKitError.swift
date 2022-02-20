//
//  BitpandaKitError.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation

// In a real app, errors would be modeled here.
enum BitpandaKitError: Error {
  
  case remoteAPINotAvailalbe
    
    var description: String {
        switch self {
        case .remoteAPINotAvailalbe:
            return NSLocalizedString("Sorry, Bitpanda remote API is not avaialble yet", comment: "Alert message")
        }
    }
}
