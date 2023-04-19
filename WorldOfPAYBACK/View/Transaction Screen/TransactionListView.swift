//
//  TransactionListView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import SwiftUI

struct TransactionListView: View {
    @ObservedObject var viewModel = TransactionListViewModel()
    
    var body: some View {
        VStack {
            
            if !viewModel.isConnected && viewModel.transactions.count == 0 {
                ErrorView(imageName: "wifi.slash", message: "No internet connection")
            } else {
                // Show loading indicator if data is being loaded
                if viewModel.isLoading {
                    LoadingView()
                }
                // Show error message if there is an error loading transactions
                else if viewModel.isError {
                    ErrorView(imageName: "exclamationmark.triangle.fill", message: viewModel.errorMessage ?? "Unknown error")
                }
                // Reload data when transactions list is empty and network status changes
                else if viewModel.transactions.isEmpty {
                    ReloadView(action: {
                        viewModel.mockRandomly()
                    })
                }
                // Show the list of transactions if data is loaded successfully
                else {
                    
                    // Show list of filtered transactions, grouped by booking date
                    NavigationView {
                        TransactionsList(transactions: viewModel.filteredTransactions,
                                         isConnected: $viewModel.isConnected,
                                         selectedTransaction: $viewModel.selectedTransaction)
                        .navigationTitle("Transactions")
                        .sheet(item: $viewModel.selectedTransaction) { transaction in
                            TransactionDetailsView(transaction: transaction)
                        }
                    }
                    
                    // Show total sum of filtered transactions
                    Section() {
                        TotalSumView(currency: viewModel.getCurrency(), amount: viewModel.getSumAmount())
                    }
                    
                    // Show segmented control for selecting category to filter transactions
                    HStack {
                        let categories = viewModel.getCategories().map({ "Category \($0)" })
                        CategoryPickerView(categories: categories, selectedCategoryIndex: $viewModel.selectedCategoryIndex)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            // Load transactions when the view appear
            // Mocking data, showing transactions and making it to fail every randomly
            viewModel.mockRandomly()
        }
        .onDisappear {
            viewModel.clearData()
        }
    }
}

struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView()
    }
}
