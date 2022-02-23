//
//  WalletListViewController.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import UIKit
import Combine
import TableFlip

class WalletListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var walletsTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fetchDataIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Attributes
    let tableViewAnimationSpeed: TimeInterval = 0.5
    
    // MARK: - Dependencies
    var subscriptions = Set<AnyCancellable>()
    var walletsListViewModel: WalletsListViewModel?
    
    // MARK: - Factory method
    static func create(walletsListViewModel: WalletsListViewModel) -> WalletListViewController {
        
        // Create instance from AssetsListViewController
        let viewController = WalletListViewController.init(nibName: WalletListViewController.defaultFileName, bundle: nil)
        
        // Assign assetListViewModel value
        viewController.walletsListViewModel = walletsListViewModel
                
        return viewController
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.bindViewToViewModel()
        self.bindModelToView()
        self.walletsListViewModel?.fetchData()
    }
    
    func reload() {
        self.tableView.reloadData()
        self.tableView.animate(animation: .left(duration: self.tableViewAnimationSpeed), completion: nil)
    }
    
    // MARK: - Private
    private func setupViews() {
        
        self.errorMessageLabel.text = ""
        self.fetchDataIndicator.stopAnimating()
        self.walletsTypeSegmentedControl.selectedSegmentIndex = 0
        self.setupTableView()
    }
    
    private func setupTableView() {
        
        self.tableView.estimatedRowHeight = FiatWalletListItemTableViewCell.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: FiatWalletListItemTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: FiatWalletListItemTableViewCell.reuseIdentifier)
        self.tableView.register(UINib(nibName: WalletListItemTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: WalletListItemTableViewCell.reuseIdentifier)
    }
}

// MARK: - Implement tableview delegates
extension WalletListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // check selected segment type
        if self.walletsListViewModel?.selectedSegmentIndex ==  SegmentTypes.wallets.rawValue {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: WalletListItemTableViewCell.reuseIdentifier, for: indexPath) as? WalletListItemTableViewCell else {
                
                assertionFailure("Cannot dequeue reusable cell \(WalletListItemTableViewCell.self) with reuseIdentifier: \(WalletListItemTableViewCell.reuseIdentifier)")
                return UITableViewCell()
            }
            
            guard let commodityWalletsItem = self.walletsListViewModel?.commodityWalletsItems[safe: indexPath.row] else {
                return UITableViewCell()
            }
            
            cell.fill(commodityWalletsItem: commodityWalletsItem)
            
            return cell
            
        } else if self.walletsListViewModel?.selectedSegmentIndex ==  SegmentTypes.fiatsWallets.rawValue {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FiatWalletListItemTableViewCell.reuseIdentifier, for: indexPath) as? FiatWalletListItemTableViewCell else {
                
                assertionFailure("Cannot dequeue reusable cell \(FiatWalletListItemTableViewCell.self) with reuseIdentifier: \(FiatWalletListItemTableViewCell.reuseIdentifier)")
                return UITableViewCell()
            }
            
            guard let fiatListViewModel = self.walletsListViewModel?.fiatWalletsItems[safe: indexPath.row] else {
                return UITableViewCell()
            }
            
            cell.fill(fiatListItemViewModel: fiatListViewModel)
            
            return cell
            
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = self.walletsListViewModel?.selectedSegmentIndex ==  SegmentTypes.wallets.rawValue ? self.walletsListViewModel?.commodityWalletsItems.count ?? 0 : self.walletsListViewModel?.fiatWalletsItems.count ?? 0
        return numberOfRows
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
         
        var estimatedHeight: CGFloat
        if self.walletsListViewModel?.selectedSegmentIndex ==  SegmentTypes.wallets.rawValue {
            
            estimatedHeight = self.walletsListViewModel?.commodityWalletsItems.isEmpty ?? true ? tableView.frame.height : UITableView.automaticDimension
        } else {
            
            estimatedHeight = self.walletsListViewModel?.fiatWalletsItems.isEmpty ?? true ? tableView.frame.height : UITableView.automaticDimension
        }

        return estimatedHeight
    }
}

// MARK: - Dynamic behavior
extension WalletListViewController {

    // View to Model
    func bindViewToViewModel() {
        self.bindSelectedSegmentToModel()
    }
    
    func bindSelectedSegmentToModel() {
        if let walletsViewModel = self.walletsListViewModel {
            self.walletsTypeSegmentedControl
                .publisher(for: \.selectedSegmentIndex)
                .receive(on: DispatchQueue.main)
                .map() { $0 }
                .assign(to: \.selectedSegmentIndex, on: walletsViewModel)
                .store(in: &subscriptions)
        }
    }
    
    // Model To View
    func bindModelToView() {
        self.bindViewModelToFetchDataActivityIndicator()
        self.bindViewModelToErrorMessageLabel()
        self.bindViewModelToTableView()
    }
    
    func bindViewModelToFetchDataActivityIndicator() {
        
        self.walletsListViewModel?
            .$fetchingActivityIndicatorAnimating
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] animating in
                switch animating {
                  case true: self?.fetchDataIndicator.startAnimating()
                  case false: self?.fetchDataIndicator.stopAnimating()
                }
            })
            .store(in: &subscriptions)
    }
    
    func bindViewModelToErrorMessageLabel() {
        self.walletsListViewModel?
            .$errorMessageLabel
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] errorMessage in
                self?.errorMessageLabel.text = errorMessage
            })
            .store(in: &subscriptions)
    }
    
    func bindViewModelToTableView() {
        
        self.walletsListViewModel?
            .walletsListPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reload()
            })
            .store(in: &subscriptions)
    }
}
