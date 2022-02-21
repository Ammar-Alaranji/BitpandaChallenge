//
//  FiatWalletListItemTableViewCell.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import UIKit

class FiatWalletListItemTableViewCell: UITableViewCell {

    // MARK: - Static Variables
    static let reuseIdentifier = String(describing: AssetListItemTableViewCell.self)
    static let height = CGFloat(60)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
