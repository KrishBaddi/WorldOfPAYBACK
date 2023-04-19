//
//  TransactionsList.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import SwiftUI

struct TransactionsList: View {
    let transactions: [Transaction]
    @Binding var isConnected: Bool
    @Binding var selectedTransaction: Transaction?
        
        var body: some View {
            List {
                if !transactions.isEmpty {
                    if !isConnected {
                        VStack {
                            Text("No internet connection")
                                .foregroundColor(.red)
                                .fontWeight(.bold)
                                .padding()
                                .multilineTextAlignment(.center)
                        }
                    }
                }
                
                ForEach(transactions) { transaction in
                    Section(header: Text(transaction.transactionDetail.bookingDate.formattedDate())) {
                        Button(action: {
                            selectedTransaction = transaction
                        })
                        {
                            VStack(alignment: .leading, spacing: 8) {
                                Text(transaction.partnerDisplayName)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                HStack {
                                    if let description = transaction.transactionDetail.description {
                                        Text(description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                        
                                    }
                                    Spacer()
                                    Text("\(transaction.transactionDetail.value.amount) \(transaction.transactionDetail.value.currency)")
                                        .font(.subheadline)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        
                    }
                }
            }
        }
}
