//
//  CollectionExtension.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation

public extension Collection {
    subscript(safe index: Index) -> Iterator.Element? {
        guard indices.contains(index) else { return nil }
        return self[index]
    }
}
