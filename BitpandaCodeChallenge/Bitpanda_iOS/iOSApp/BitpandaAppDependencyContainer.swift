//
//  BitpandaAppDependencyContainer.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import UIKit

class BitpandaAppDependencyContainer: BitpandaNavigation {
    
    // MARK: - Properties
    var navigationFactory: ((BitpandaMainNavigationViewController) -> Void)?
    
    // MARK: - Methods
    
    // MARK: - Factory Methods
    func makeMainNavigationViewController() -> UINavigationController {
                
        return BitpandaMainNavigationViewController.create()
    }
}
 
protocol BitpandaNavigation {
    
    // MARK: - Factory Methods
    func makeMainNavigationViewController() -> UINavigationController
}
