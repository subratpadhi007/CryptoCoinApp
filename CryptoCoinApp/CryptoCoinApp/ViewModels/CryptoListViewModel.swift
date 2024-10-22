//
//  CryptoListViewModel.swift
//  CryptoCoinApp
//
//  Created by Subrat Padhi on 21/10/24.
//

import Foundation

class CryptoListViewModel {

    // MARK: - Properties
    private var apiService = APIService()
    private var allCoins = [CryptoCoin]() {
        didSet {
            filteredCoins = allCoins
        }
    }

    var filteredCoins = [CryptoCoin]() {
        didSet {
            self.reloadTableViewClosure?()
        }
    }
    
    var reloadTableViewClosure: (() -> Void)?

    // MARK: - Initialization
    init() {
        
    }

    // MARK: - Fetching Data
    func fetchCryptoCoins() {
        apiService.getCryptoData { [weak self] (result) in
            switch result {
            case .success(let coins):
                self?.allCoins = coins
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    // MARK: - Filtering
    func filterContentForSearchText(_ searchText: String) {
        if searchText.isEmpty {
            filteredCoins = allCoins
        } else {
            filteredCoins = allCoins.filter { $0.name.lowercased().contains(searchText.lowercased()) || $0.symbol.lowercased().contains(searchText.lowercased()) }
        }
    }

    func applyFilter(active: Bool? = nil, type: String? = nil, isNew: Bool? = nil) {
        filteredCoins = allCoins.filter { coin in
            var matchesActive = true
            var matchesType = true
            var matchesNew = true

            if let active = active {
                matchesActive = coin.isActive == active
            }
            if let type = type {
                matchesType = coin.type == type
            }
            if let isNew = isNew {
                matchesNew = coin.isNew == isNew
            }

            return matchesActive && matchesType && matchesNew
        }
    }
}

