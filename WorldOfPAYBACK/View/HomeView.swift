//
//  HomeView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 16/04/2023.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome to the World of PAYBACK")
                NavigationLink(destination: TransactionListView()) {
                    Text("Go to Transactions")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationBarHidden(true)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
