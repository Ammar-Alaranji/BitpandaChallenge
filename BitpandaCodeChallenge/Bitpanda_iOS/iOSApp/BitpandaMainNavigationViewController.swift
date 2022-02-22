//
//  BitpandaMainNavigationViewController.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import UIKit

class BitpandaMainNavigationViewController: UINavigationController {

    // MARK: - Create Methods
    static func create() -> UINavigationController {
        
        let navController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BitpandaNavigationController") as! UINavigationController
        
        return navController
    }
}

protocol MainNavigationViewControllerFactory {
    
    // MARK: - Factory Methods
    func makeMainNavigationViewController() -> UINavigationController
}
