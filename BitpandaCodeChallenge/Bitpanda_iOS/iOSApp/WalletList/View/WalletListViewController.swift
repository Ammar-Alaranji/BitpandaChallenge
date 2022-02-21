//
//  WalletListViewController.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/21/22.
//

import UIKit
import Combine

class WalletListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var walletsTypeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fetchDataIndicator: UIActivityIndicatorView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    // MARK: - Dependencies
    var subscriptions = Set<AnyCancellable>()
    var walletsListViewModel: WalletsListViewModel?
    
    // MARK: - Factory method
    static func create(walletsListViewModel: WalletsListViewModel) -> UIViewController {
        
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
    }
    
    // MARK: - Private
    private func setupViews() {
        
        self.errorMessageLabel.text = ""
        self.fetchDataIndicator.stopAnimating()
        self.walletsTypeSegmentedControl.selectedSegmentIndex = 0
        self.setupTableView()
    }
    
    private func setupTableView() {
        
        self.tableView.estimatedRowHeight = AssetListItemTableViewCell.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: AssetListItemTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AssetListItemTableViewCell.reuseIdentifier)
    }
}

// MARK: - Implement tableview delegates
extension WalletListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 0
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
            .$walletsListItem
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                self?.reload()
            })
            .store(in: &subscriptions)
    }
}
