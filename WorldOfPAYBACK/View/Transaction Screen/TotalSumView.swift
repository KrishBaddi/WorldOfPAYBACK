//
//  TotalSumView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import SwiftUI

struct TotalSumView: View {
    
    let currency: String
    let amount: Int
    
    init(currency: String, amount: Int) {
        self.currency = currency
        self.amount = amount
    }
    
    var body: some View {
        Section() {
            VStack {
                Text("Total")
                Text("\(currency): \(amount)")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.gray)
            }.padding()
        }
    }
}

struct TotalSumView_Previews: PreviewProvider {
    static var previews: some View {
        TotalSumView(currency: "PBP", amount: 100)
    }
}
