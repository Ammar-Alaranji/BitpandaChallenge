//
//  AssetsRepository.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/19/22.
//

import Foundation
import Promises

protocol AssetsRepository {
    
    func fetchAssets() -> Promise<[Asset]>
}
