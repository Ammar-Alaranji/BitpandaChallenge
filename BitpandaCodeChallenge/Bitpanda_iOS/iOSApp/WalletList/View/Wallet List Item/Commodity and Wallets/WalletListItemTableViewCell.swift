//
//  WalletListItemTableViewCell.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import UIKit

class WalletListItemTableViewCell: UITableViewCell {

    // MARK: - Static Variables
    static let reuseIdentifier = String(describing: WalletListItemTableViewCell.self)
    static let height = CGFloat(60)
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var balance: UILabel!
    @IBOutlet weak var symbolLabel: UILabel!
    @IBOutlet weak var symbolImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func fill(commodityWalletsItem: CommodityListItemViewModel) {
        self.iconImageView.isHidden = !commodityWalletsItem.isDefault
        // Fill wallet's name
        self.nameLabel.text = commodityWalletsItem.name
        // Fill wallet's balance
        self.balance.text = commodityWalletsItem.balance.currency(maximumFractionDigits: nil)
        // Fill wallet'scrypto symbol
        self.symbolLabel.text = commodityWalletsItem.cryptoSymbol
        // Fill wallet's cryptoIcon icon
        self.symbolImageView.downloadedsvg(from: commodityWalletsItem.cryptoIcon, withPlaceHolder: UIImage(named: "placeHolder"))
        
    }
    
}
