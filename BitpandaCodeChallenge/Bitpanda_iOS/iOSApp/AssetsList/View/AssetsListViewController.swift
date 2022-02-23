//
//  AssetsListViewController.swift
//  BitpandaCodeChallenge
//
//  Created by Ammar Alaranji on 2/20/22.
//

import UIKit
import Combine
import TableFlip

class AssetsListViewController: UIViewController {

    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    @IBOutlet weak var fetchDataActivityIndicator: UIActivityIndicatorView!
    let searchController = UISearchController()
    
    // MARK: - Attributes
    let tableViewAnimationSpeed: TimeInterval = 0.5
    
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

        // Setup all views
        self.setupViews()
        // Bind view/viewmodel
        self.bindFieldsToViewModel()
        self.bindViewModelToViews()
        // load data
        self.assetListViewModel?.loadAssetsData()
        
        self.navigationController?.isNavigationBarHidden = false
    }
    
    func reload(withAnimation: Bool) {
        tableView.reloadData()
        if withAnimation {
            self.tableView.animate(animation: .left(duration: self.tableViewAnimationSpeed), completion: nil)
        }
    }
    
    // MARK: - Private
    private func setupViews() {
        
        self.errorMessageLabel.text = ""
        self.fetchDataActivityIndicator.stopAnimating()
        self.setupTableView()
        self.initSearchController()
    }
    
    private func setupTableView() {
        
        self.tableView.estimatedRowHeight = AssetListItemTableViewCell.height
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.register(UINib(nibName: AssetListItemTableViewCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: AssetListItemTableViewCell.reuseIdentifier)
    }
    
    private func initSearchController()
        {
            self.navigationController?.isNavigationBarHidden = true
            searchController.loadViewIfNeeded()
            searchController.searchResultsUpdater = self
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.enablesReturnKeyAutomatically = false
            searchController.searchBar.returnKeyType = UIReturnKeyType.done
            definesPresentationContext = true
            
            navigationItem.searchController = searchController
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.searchBar.scopeButtonTitles = self.assetListViewModel?.searchBarButtonTitles
            searchController.searchBar.selectedScopeButtonIndex = 0
            searchController.searchBar.delegate = self
            searchController.searchBar.searchTextField.accessibilityIdentifier = AccessibilityIdentifier.assetsSearchField
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

    func bindFieldsToViewModel() {
      
        self.bindSearchBarActiveStatus()
    }
    
    func bindSearchBarActiveStatus() {
        if let assetListViewModel = assetListViewModel {
            self.searchController
                .publisher(for: \.isActive)
                .receive(on: DispatchQueue.main)
                .map() { $0 }
                .assign(to: \.isSearchBarActive, on: assetListViewModel)
                .store(in: &subscriptions)
        }
    }
    
    func bindViewModelToViews() {
        self.bindViewModelToFetchDataActivityIndicator()
        self.bindViewModelToErrorMessageLabel()
        self.bindViewModelToTableView()
        self.bindViewModelToFiltersTitles()
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
            .AssetsListPublisher
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] shouldAnimate in
                self?.reload(withAnimation: shouldAnimate)
            })
            .store(in: &subscriptions)
    }
    
    func bindViewModelToFiltersTitles() {
        
        self.assetListViewModel?
            .$searchBarButtonTitles
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] typesList in
                self?.searchController.searchBar.scopeButtonTitles = typesList
            })
            .store(in: &subscriptions)
    }
}

// MARK: - implement SearchBar delegates
extension AssetsListViewController: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        let searchText = searchBar.text ?? ""
        let selectedScopeButtonText = searchBar.scopeButtonTitles?[searchBar.selectedScopeButtonIndex] ?? ""
        
        self.assetListViewModel?.applyFilter(searchText: searchText,
                                             appliedFilter: selectedScopeButtonText,
                                             searchIsActive: searchController.isActive)
    }
}
