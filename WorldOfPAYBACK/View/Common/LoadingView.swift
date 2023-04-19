//
//  LoadingView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        VStack {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .blue))
            
            Text("Loading...")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.gray)
                .padding(.top, 8)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
