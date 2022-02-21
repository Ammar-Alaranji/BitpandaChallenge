//
//  FiatWalletListItemTableViewCell.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import UIKit
import Combine

class FiatWalletListItemTableViewCell: UITableViewCell {
    
    // MARK: - Static Variables
    static let reuseIdentifier = String(describing: FiatWalletListItemTableViewCell.self)
    static let height = CGFloat(60)
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func fill(fiatListItemViewModel: FiatListItemViewModel) {
        
        // Fill name and symbol details
        self.nameLabel.text = fiatListItemViewModel.name
        // Fill average price details
        self.balance.text = fiatListItemViewModel.balance
        // Fill fiat symbol details
        self.symbolLabel.text = fiatListItemViewModel.fiatSymbol
    }
}
