//
//  WalletsListViewModel.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import Foundation
import Combine

class WalletsListViewModel {
    
    // MARK: - Properties
    let walletsRepository: WalletsRepository
    let assetRepository: AssetsRepository
    var walletsListItem: Wallets = Wallets()
    var fiatWalletsItems: [FiatListItemViewModel] = []
    var commodityWalletsItems: [CommodityListItemViewModel] = []
    
    // MARK: - Binded Properties
    var selectedSegmentIndex: Int = 0 {
        didSet {
            // to notify the wallets controller to reload its tableView
            self.walletsListSubject.send()
        }
    }
    
    // MARK: - Methods
    init(walletsRepository: WalletsRepository,
         assetRepository: AssetsRepository) {
        self.walletsRepository = walletsRepository
        self.assetRepository = assetRepository
    }
    
    // MARK: - Publishers
    public var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessagesSubject.eraseToAnyPublisher()
    }
    private let errorMessagesSubject = PassthroughSubject<ErrorMessage, Never>()
    
    public var walletsListPublisher: AnyPublisher<Void, Never> {
        walletsListSubject.eraseToAnyPublisher()
    }
    private let walletsListSubject = PassthroughSubject<Void, Never>()
    
    @Published public private(set) var errorMessageLabel: String = ""
    @Published public private(set) var fetchingActivityIndicatorAnimating = false
    
    // MARK: - Fetch and Handle
    func fetchData() {
        self.indicateFetchingData()
        // Handle the promise result/error
        self.walletsRepository.getWallets()
            .then(on: .global()) { wallets in
                // fetch assets data
                self.assetRepository.fetchAssets()
                    .then(on: .global()) { assets in
                        self.walletsListItem = wallets
                        // update view model items
                        self.updateViewModelItems(assets: assets)
                        // Indicate finish getting data with success results
                        self.indicateFinishFetchingData()
                    }
                    .catch { error in
                        self.indicateFetchDataError(error: error)
                    }
            }.catch { error in
                // Handle the returned error and send it with the error message publisher
                self.indicateFetchDataError(error: error)
            }
    }
    
    func updateViewModelItems(assets: [Asset]) {
        // map fiat wallets to FiatListItemViewModel
        self.fiatWalletsItems = self.walletsListItem.fiatWallets.map({ fiatWallet in
            
            let matchedAsset = assets.first { asset in
                asset.id == fiatWallet.attributes.fiatId
            }
            return FiatListItemViewModel(fiatWalet: fiatWallet, fiatIcon: matchedAsset?.attributes.icon ?? URL(fileURLWithPath: ""))
        }).sorted(by: { first, second in
            return first > second
        })
        
        // map wallets to CommodityListItemViewModel, then remove deleted items
        self.commodityWalletsItems = self.walletsListItem.commodityWallets.map({ commodityWalet in
            let matchedAsset = assets.first { asset in
                asset.id == commodityWalet.attributes.cryptocoinId
            }
            return CommodityListItemViewModel(commodityWalet: commodityWalet, cryptoIcon: matchedAsset?.attributes.icon ?? URL(fileURLWithPath: ""))
        }).filter({ commodityWalet in
            return !commodityWalet.deleted
        }).sorted(by: { first, second in
            return first > second
        })
        
        // to notify the wallets controller to reload its tableView
        self.walletsListSubject.send()
    }
}

// MARK: - Fetch Data Methods
extension WalletsListViewModel {
    
    func indicateFetchingData() {
        // Reset error message/label
        self.errorMessageLabel = ""
        // Ask the indicator to start animating
        self.fetchingActivityIndicatorAnimating = true
    }
    
    func indicateFinishFetchingData() {
        // Reset error message/label
        if self.selectedSegmentIndex == SegmentTypes.wallets.rawValue {
            self.errorMessageLabel = self.walletsListItem.commodityWallets.isEmpty ? NSLocalizedString("You don't have any wallets", comment: "Empty assets error message") : ""
        } else {
            self.errorMessageLabel = self.walletsListItem.fiatWallets.isEmpty ? NSLocalizedString("You don't have any fiat wallets", comment: "Empty assets error message") : ""
        }
        // Ask the indicator to start animating
        self.fetchingActivityIndicatorAnimating = false
    }
    
    func indicateFetchDataError(error: Error) {
        let errorMessageString = NSLocalizedString("Sorry, We couldn't load your wallets", comment: "On-screen error message")
        errorMessagesSubject.send(ErrorMessage(title: NSLocalizedString("Opps!", comment: "On-screen error message title message"), message: errorMessageString))
        
        // Show the error message
        self.errorMessageLabel = errorMessageString
        // Ask the activity indicator to stop animating
        self.fetchingActivityIndicatorAnimating = false
    }
}

enum SegmentTypes: Int {
    case wallets = 0
    case fiatsWallets
}
