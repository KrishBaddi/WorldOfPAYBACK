//
//  CategoryPickerView.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import SwiftUI

struct CategoryPickerView: View {
    let categories: [String]
    @Binding var selectedCategoryIndex: Int
    
    var body: some View {
        Picker(selection: $selectedCategoryIndex, label: Text("Select a category")) {
            Text("All")
                .foregroundColor(.white)
                .tag(0)
            
            ForEach(categories.indices) { index in
                Text(categories[index])
                    .tag(index + 1)
                    .foregroundColor(.white)
            }
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding(.horizontal)
        .id(selectedCategoryIndex)
    }
}

struct CategoryPickerView_Previews: PreviewProvider {
    @State var selectedCategoryIndex: Int
    static var previews: some View {
        CategoryPickerView(categories: ["Category1", "Category2"], selectedCategoryIndex: .constant(0))
    }
}
