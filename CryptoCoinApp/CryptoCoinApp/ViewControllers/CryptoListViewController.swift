//
//  CryptoListViewController.swift
//  CryptoCoinApp
//
//  Created by Subrat Padhi on 21/10/24.
//

import UIKit

class CryptoListViewController: UIViewController {
    
    //MARK: - Properties
    var tableView: UITableView!
    var searchController: UISearchController!
    var viewModel = CryptoListViewModel()
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupSearchController()
        setupBindings()
        
        viewModel.fetchCryptoCoins()
    }
    
    //MARK: - Private Methods
    private func setupUI() {
        self.title = "Cryptocurrencies"
        view.backgroundColor = .white
        setupTableView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        tableView.register(CryptoTableViewCell.self, forCellReuseIdentifier: "cryptoCell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        navigationItem.largeTitleDisplayMode = .never
        let filterButton = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(showFilterOptions))
        navigationItem.rightBarButtonItem = filterButton
    }
    
    private func setupSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Cryptocurrencies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func setupBindings() {
        viewModel.reloadTableViewClosure = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    private func showCryptoDetailPopup(coin: CryptoCoin) {
        let alertController = UIAlertController(title: coin.name, message: "Symbol: \(coin.symbol)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true)
    }
    
    @objc private func showFilterOptions() {
        let alertController = UIAlertController(title: "Filter", message: "Select a filter option", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "All", style: .default, handler: { _ in
            self.viewModel.applyFilter()
        }))
        
        alertController.addAction(UIAlertAction(title: "Active Coins", style: .default, handler: { _ in
            self.viewModel.applyFilter(active: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Inactive Coins", style: .default, handler: { _ in
            self.viewModel.applyFilter(active: false)
        }))
        
        alertController.addAction(UIAlertAction(title: "Only Tokens", style: .default, handler: { _ in
            self.viewModel.applyFilter(type: "token")
        }))
        
        alertController.addAction(UIAlertAction(title: "Only Coins", style: .default, handler: { _ in
            self.viewModel.applyFilter(type: "coin")
        }))
        
        alertController.addAction(UIAlertAction(title: "New Coins", style: .default, handler: { _ in
            self.viewModel.applyFilter(isNew: true)
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource and UITableViewDelegate
extension CryptoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.filteredCoins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cryptoCell", for: indexPath) as? CryptoTableViewCell else {
            return UITableViewCell()
        }
        
        let coin = viewModel.filteredCoins[indexPath.row]
        cell.configure(with: coin)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let coin = viewModel.filteredCoins[indexPath.row]
        showCryptoDetailPopup(coin: coin)
    }
}

// MARK: - UISearchResultsUpdating
extension CryptoListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        viewModel.filterContentForSearchText(searchController.searchBar.text ?? "")
    }
}
