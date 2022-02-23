//
//  UIViewControllerExtension.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import UIKit

extension UIViewController {
    
    static var defaultFileName: String {
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
}
