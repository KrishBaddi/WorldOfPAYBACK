//
//  ErrorView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import SwiftUI

struct ErrorView: View {
    let imageName: String
    let message: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(systemName: imageName)
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text(message)
                .font(.headline)
                .foregroundColor(.red)
                .multilineTextAlignment(.center)
        }
        .shadow(radius: 4)
    }
}

struct ErrorView_Previews: PreviewProvider {
    static var previews: some View {
        ErrorView(imageName: "wifi.slash", message: "No internet connection")
    }
}
