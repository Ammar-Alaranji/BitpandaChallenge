//
//  AssetsListViewController.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import UIKit
import Combine

class AssetsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var fetchDataActivityIndicator: UIActivityIndicatorView!
    
    // MARK: - Dependencies
    var subscriptions = Set<AnyCancellable>()
    private var assetListViewModel: AssetsListViewModel?
    
    // MARK: - Factory method
    static func create(assetListViewModel: AssetsListViewModel) -> AssetsListViewController {
        
        // Create instance from AssetsListViewController
        let viewController = AssetsListViewController.init(nibName: AssetsListViewController.defaultFileName, bundle: nil)
        
        // Assign assetListViewModel value
        viewController.assetListViewModel = assetListViewModel
        
        return viewController
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupViews()
        self.bindViewModelToViews()
        self.assetListViewModel?.loadAssetsData()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    // MARK: - Private
    private func setupViews() {
        
        self.errorMessageLabel.text = ""
        self.fetchDataActivityIndicator.stopAnimating()
        
        self.tableView.estimatedRowHeight = AssetListItemTableViewCell.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: AssetListItemTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AssetListItemTableViewCell.reuseIdentifier)
    }
}

// MARK: - Implement tableview delegates
extension AssetsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AssetListItemTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? AssetListItemTableViewCell else {
            assertionFailure("Cannot dequeue reusable cell \(AssetListItemTableViewCell.self) with reuseIdentifier: \(AssetListItemTableViewCell.reuseIdentifier)")
            return UITableViewCell()
        }
        
        if let assetListViewModel = self.assetListViewModel, let asset = assetListViewModel.assetsListItems[safe: indexPath.row] {
                
            cell.fill(assetListItemViewModel: asset)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.assetListViewModel?.assetsListItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.assetListViewModel?.isEmpty ?? true ? tableView.frame.height : UITableView.automaticDimension
    }
}

// MARK: - Dynamic behavior
extension AssetsListViewController {

    func bindViewModelToViews() {
        self.bindViewModelToFetchDataActivityIndicator()
        self.bindViewModelToErrorMessageLabel()
        self.bindViewModelToTableView()
    }
    
    func bindViewModelToFetchDataActivityIndicator() {
        
        self.assetListViewModel?
            .$fetchingActivityIndicatorAnimating
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] animating in
                switch animating {
                  case true: self?.fetchDataActivityIndicator.startAnimating()
                  case false: self?.fetchDataActivityIndicator.stopAnimating()
                }
            })
            .store(in: &subscriptions)
    }
    
    func bindViewModelToErrorMessageLabel() {
        self.assetListViewModel?
            .$errorMessageLabel
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] errorMessage in
                self?.errorMessageLabel.text = errorMessage
            })
            .store(in: &subscriptions)
    }
    
    func bindViewModelToTableView() {
        
        self.assetListViewModel?
            .$assetsListItems
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] assets in
                self?.reload()
            })
            .store(in: &subscriptions)
    }
}
