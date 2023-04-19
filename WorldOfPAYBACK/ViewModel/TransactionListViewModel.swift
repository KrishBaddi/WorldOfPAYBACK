//
//  TransactionListViewModel.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import Foundation
import Combine

var randomlyFailing = false

class TransactionListViewModel: ObservableObject {
    // Published properties
    @Published var transactions = [Transaction]()
    @Published var filteredTransactions = [Transaction]()
    @Published var isLoading = false
    @Published var isError = false
    @Published var selectedTransaction: Transaction?
    @Published var isConnected = true
    @Published var errorMessage: String?
    
    // Private properties
    private var apiManager: APIManagerProtocol
    private var cancellables = Set<AnyCancellable>()
    
    // Property to randomly fail the API response
    private var randomlyFailing = false
    
    // Index of the selected category, defaults to 0 (all transactions)
    var selectedCategoryIndex = 0 {
        didSet {
            filterTransactions()
        }
    }
    
    // Initializer
    init(apiManager: APIManagerProtocol = MockAPIManager()) {
        self.apiManager = apiManager
        
        // Observe network connectivity using Reachability
        Reachability.shared.publisher
            .map { path in path.isReachable }
            .sink { [weak self] isConnected in
                self?.isConnected = isConnected
            }
            .store(in: &cancellables)
    }
    
    // Method to randomly mock a failed API response
    func mockRandomly() {
        if isConnected {
            let n = 5 // randomly mock the data 5 times
            let randomMock = Int.random(in: 0..<n)
            if randomMock == 0 {
                apiManager.response = Fail(error: APIError.invalidResponse).eraseToAnyPublisher()
            } else {
                apiManager.response = Just(PBTransactions.mock)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            loadTransactions()
        }
    }
    
    // Method to load transactions from API
    func loadTransactions() {
        isLoading = true
        isError = false
        
        apiManager.fetchGitHubObjects(modelType: PBTransactions.self, endpoint: .getTransactions, customParams: [:])
            .map { items in
                // Sort transactions by booking date (newest first)
                let transactions = items.transactions
                return transactions.sorted { $0.transactionDetail.bookingDate > $1.transactionDetail.bookingDate }
            }
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished: break
                case .failure(let error):
                    // Handle API error
                    self.isError = true
                    self.isLoading = false
                    if let apiError = error as? APIError {
                        self.errorMessage = apiError.errorMessage
                    }
                }
            }, receiveValue: { transactions in
                // Update transactions and filteredTransactions after a delay of 3 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    self.isLoading = false
                    self.isError = false
                    self.transactions = transactions
                    self.filterTransactions()
                }
            })
            .store(in: &cancellables)
    }
    
    // Method to filter transactions by selected category
    func filterTransactions() {
        let categories = getCategories()
        if selectedCategoryIndex == 0 {
            // Show all transactions
            filteredTransactions = transactions
        } else {
            // Show transactions of the selected category
            let selectedCategory = categories.first(where: { $0 == selectedCategoryIndex })
            filteredTransactions = transactions.filter {  $0.category == selectedCategory }
        }
    }
    
    // Method to get unique categories of all transactions
    func getCategories() -> [Int] {
        Array(Set(transactions.map { $0.category }))
    }
    
    // Method to get currency of the transactions
    func getCurrency() -> String {
        if let currency = transactions.first?.transactionDetail.value.currency {
            return currency.localizedCapitalized.uppercased()
        }
        return ""
    }
    
    // Method to get total amount for filtered transactins
    func getSumAmount() -> Int {
        filteredTransactions.reduce(0) { $0 + $1.transactionDetail.value.amount }
    }
    
    func clearData()  {
        self.transactions = []
        self.filteredTransactions = []
    }
}
