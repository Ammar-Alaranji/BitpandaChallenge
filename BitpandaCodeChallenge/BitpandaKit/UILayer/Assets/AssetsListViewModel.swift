//
//  AssetsListViewModel.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import Foundation
import Combine

class AssetsListViewModel {
    
    // MARK: - Properties
    var assetsRepository: AssetsRepository
    var isEmpty: Bool { return self.assetsListItems.isEmpty }
    var searchBarButtonTitlesSet: Set<String> = []
    var allAssetsList: [AssetListItemViewModel] = []
    var assetsListItems: [AssetListItemViewModel] = []
    
    // MARK: - Binded Properties
    var isSearchBarActive: Bool = false
    
    // MARK: - Methods
    init(assetsRepository: AssetsRepository) {
        self.assetsRepository = assetsRepository
    }
    
    // MARK: - Publishers
    public var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessagesSubject.eraseToAnyPublisher()
    }
    private let errorMessagesSubject = PassthroughSubject<ErrorMessage, Never>()
    
    public var AssetsListPublisher: AnyPublisher<Void, Never> {
        assetsListSubject.eraseToAnyPublisher()
    }
    private let assetsListSubject = PassthroughSubject<Void, Never>()
    
    @Published public private(set) var searchBarButtonTitles: [String] = []
    @Published public private(set) var errorMessageLabel: String = ""
    @Published public private(set) var fetchingActivityIndicatorAnimating = false
    
    // MARK: - Fetch and Handle
    func loadAssetsData() {
        self.indicateFetchingData()
        self.assetsRepository.fetchAssets()
        // Handle the promise result/error
            .then(on: .main) { assets in
                // fill the view model items array with the assets attributes
                self.groupAssetsAttributes(assets: assets)
                // Indicate finish getting data with success results
                self.indicateFinishFetchingData()
            }.catch(on: .main) { error in
                // Handle the returned error and send it with the error message publisher
                self.indicateFetchDataError(error: error)
            }
    }
    
    // Group assets attributes to one list
    func groupAssetsAttributes(assets: [Asset]) {
        var tempListItem: [Asset] = []
        // Get all cryptocoins and commodities, only fiats that has wallet true value
        tempListItem.append(contentsOf: assets.filter({ asset in
             
            return (asset.type == .fiat && asset.attributes.hasWalet ?? false) || (asset.type != .fiat)
        }))
        
        // Map the Assets array to AssetListItemViewModel array
        self.assetsListItems = tempListItem.map({ asset in
            self.searchBarButtonTitlesSet.insert(asset.type.rawValue.capitalized)
            return AssetListItemViewModel(asset: asset)
        })
        
        // Append All type to searchBarButtonTitlesSet
        self.searchBarButtonTitlesSet.insert("All")
        
        self.searchBarButtonTitles = self.searchBarButtonTitlesSet.sorted(by: { firstAssetType, secondAssetType in
            return firstAssetType < secondAssetType
        })
        self.allAssetsList = self.assetsListItems
        
        // to notify the wallets controller to reload its tableView
        self.assetsListSubject.send()
    }
    
    func applyFilter(searchText: String, appliedFilter: String = "All", searchIsActive: Bool) {
        
        self.assetsListItems = self.allAssetsList.filter { assetItem in
            
            if !searchIsActive {
                return true
            }
            
            var filterPredicat: Bool = false
            if appliedFilter == "All" || appliedFilter.lowercased().contains(assetItem.type.rawValue.lowercased()) {
                filterPredicat = true
            }
                        
            // Only apply text search on the selected group as well
            if filterPredicat {
                // if searchtext is empty return the item,
                return searchText.isEmpty ? true : assetItem.name.lowercased().contains(searchText.lowercased())
            } else {
                // filter when search is not active
                return filterPredicat
            }
        }
        
        self.assetsListSubject.send()
    }
}

// MARK: - Fetch Data Methods
extension AssetsListViewModel {
    
    func indicateFetchingData() {
        // Reset error message/label
        self.errorMessageLabel = ""
        // Ask the indicator to start animating
        self.fetchingActivityIndicatorAnimating = true
    }
    
    func indicateFinishFetchingData() {
        // Reset error message/label
        self.errorMessageLabel = self.isEmpty ? NSLocalizedString("You don't have any assets", comment: "Empty assets error message") : ""
        // Ask the indicator to start animating
        self.fetchingActivityIndicatorAnimating = false
    }
    
    func indicateFetchDataError(error: Error) {
        let errorMessageString = NSLocalizedString("Sorry, We couldn't load your assets", comment: "On-screen error message")
        errorMessagesSubject.send(ErrorMessage(title: NSLocalizedString("Opps!", comment: "On-screen error message title message"), message: errorMessageString))
        
        // Show the error message
        self.errorMessageLabel = errorMessageString
        // Ask the activity indicator to stop animating
        self.fetchingActivityIndicatorAnimating = false
    }
}

enum FilterTypes: String {
    case all
    case cryptocoins
    case commodities
    case fiats
    
    var description: String {
        switch self {
        case .all:
            return NSLocalizedString("All", comment: "Asset filter button title")
        case .cryptocoins:
            return NSLocalizedString("Cryptocoins", comment: "Asset filter button title")
        case .commodities:
            return NSLocalizedString("Commodities", comment: "Asset filter button title")
        case .fiats:
            return NSLocalizedString("Fiats", comment: "Asset filter button title")
        }
    }
    
    static var list: [String] {
        return [FilterTypes.all.description,
                FilterTypes.cryptocoins.description,
                FilterTypes.commodities.description,
                FilterTypes.fiats.description]
    }
}

