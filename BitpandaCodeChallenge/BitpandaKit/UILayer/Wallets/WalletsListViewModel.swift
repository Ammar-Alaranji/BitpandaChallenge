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
    
    // MARK: - Binded Properties
    var selectedSegmentIndex: Int = 0 
    
    // MARK: - Methods
    init(walletsRepository: WalletsRepository) {
        self.walletsRepository = walletsRepository
    }
    
    // MARK: - Publishers
    public var errorMessagePublisher: AnyPublisher<ErrorMessage, Never> {
        errorMessagesSubject.eraseToAnyPublisher()
    }
    private let errorMessagesSubject = PassthroughSubject<ErrorMessage, Never>()
    
    @Published public private(set) var walletsListItem: Wallets = Wallets()
    @Published public private(set) var errorMessageLabel: String = ""
    @Published public private(set) var fetchingActivityIndicatorAnimating = false
    
    // MARK: - Fetch and Handle
    func fetchData() {
        self.indicateFetchingData()
        // Handle the promise result/error
        self.walletsRepository.getWallets()
            .then(on: .global()) { wallets in
                self.walletsListItem = wallets
                // Indicate finish getting data with success results
                self.indicateFinishFetchingData()
            }.catch { error in
                // Handle the returned error and send it with the error message publisher
                self.indicateFetchDataError(error: error)
            }
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
