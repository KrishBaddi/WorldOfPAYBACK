//
//  TransactionDetailsView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 16/04/2023.
//

import SwiftUI

struct TransactionDetailsView: View {
    let transaction: Transaction
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Text(transaction.partnerDisplayName)
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            if let description = transaction.transactionDetail.description {
                Text(description)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                HStack {
                    Text("Date")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text(transaction.transactionDetail.bookingDate.formattedDate())
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Amount")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(transaction.transactionDetail.value.amount) \(transaction.transactionDetail.value.currency)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
                HStack {
                    Text("Category")
                        .font(.headline)
                        .foregroundColor(.gray)
                    Spacer()
                    Text("\(transaction.category)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                
            }
            .padding(.horizontal, 16)
        }
        .navigationTitle("Transaction Details")
        .padding(.vertical, 16)
    }
}

struct TransactionDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetailsView(transaction: PBTransactions.mock.transactions.first!)
    }
}
