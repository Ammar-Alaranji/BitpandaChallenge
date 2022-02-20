//
//  AssetListItemTableViewCell.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import UIKit
import Combine

class AssetListItemTableViewCell: UITableViewCell {

    // MARK: - Static Variables
    static let reuseIdentifier = String(describing: AssetListItemTableViewCell.self)
    static let height = CGFloat(60)
    
    // MARK: - Outlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avergePriceLabel: UILabel!
    
    // MARK: - Dependencies
    var subscriptions = Set<AnyCancellable>()
    private var assetListItemViewModel: AssetListItemViewModel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.bindViewModelToViews()
    }
    
    func fill(assetListItemViewModel: AssetListItemViewModel) {
        
        self.assetListItemViewModel = assetListItemViewModel
        
        // Fill name and symbol details
        self.nameLabel.text = assetListItemViewModel.name
        
        // Fill average price details
        self.avergePriceLabel.text = assetListItemViewModel.avergePrice

        self.iconImageView.downloadedsvg(from: assetListItemViewModel.icon, withPlaceHolder: UIImage(named: "placeHolder"))
     }
}

// MARK: - Dynamic behavior
extension AssetListItemTableViewCell {

    func bindViewModelToViews() {
        self.bindViewModelToAveragePriceLabel()
    }
    
    func bindViewModelToAveragePriceLabel() {
        
        self.assetListItemViewModel?
            .$averagePriceIsHidden
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] hiddenStatus in
                self?.avergePriceLabel.isHidden = hiddenStatus
            })
            .store(in: &subscriptions)
    }
}
