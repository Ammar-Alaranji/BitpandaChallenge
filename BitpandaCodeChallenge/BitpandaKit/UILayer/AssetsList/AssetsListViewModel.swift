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
    
    // MARK: - Methods
    init(assetsRepository: AssetsRepository) {
        self.assetsRepository = assetsRepository
    }
    
    // MARK: - Publishers
    public var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessagesSubject.eraseToAnyPublisher()
    }
    private let errorMessagesSubject = PassthroughSubject<ErrorMessage, Never>()
    
    @Published public private(set) var assetsListItems: [AssetListItemViewModel] = []
    @Published public private(set) var errorMessageLabel: String = ""
    @Published public private(set) var fetchingActivityIndicatorAnimating = false
    
    var isEmpty: Bool { return self.assetsListItems.isEmpty }
    
    // Fetch assets data
    func loadAssetsData() {
        self.indicateFetchingData()
        self.assetsRepository.fetchAssets()
        // Handle the promise result/error
            .then(on: .main) { attributes in
                // fill the view model items array with the assets attributes
                self.groupAssetsAttributes(attributes: attributes)
                // Indicate finish getting data with success results
                self.indicateFinishFetchingData()
            }.catch(on: .main) { error in
                // Handle the returned error and send it with the error message publisher
                self.indicateFetchDataError(error: error)
            }
    }
    
    // Group assets attributes to one list
    func groupAssetsAttributes(attributes: Attributes) {
        var tempListItem: [Asset] = []
        tempListItem.append(contentsOf: attributes.cryptocoins)
        tempListItem.append(contentsOf: attributes.commodities)
        // Filter the fiat list and onlt include the fiat with has wallet true
        tempListItem.append(contentsOf: attributes.fiats.filter({ fiat in
            return fiat.attributes.hasWalet ?? false
        }))
        
        self.assetsListItems = tempListItem.map({ Asset in
            return AssetListItemViewModel(asset: Asset)
        })
    }
    
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
        let errorMessageString = NSLocalizedString("Sorry, We couldn't load the Assets Data", comment: "On-screen error message")
        errorMessagesSubject.send(ErrorMessage(title: NSLocalizedString("Opps!", comment: "On-screen error message title message"), message: errorMessageString))
        
        // Show the error message
        self.errorMessageLabel = errorMessageString
        // Ask the activity indicator to stop animating
        self.fetchingActivityIndicatorAnimating = false
    }
}
