//
//  ReloadView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import SwiftUI

struct ReloadView: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Text("Reload")
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(8)
        }
    }
}

struct ReloadView_Previews: PreviewProvider {
    static var previews: some View {
        ReloadView(action: {
            
        })
    }
}
