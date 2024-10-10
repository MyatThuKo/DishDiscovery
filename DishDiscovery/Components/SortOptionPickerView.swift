//
//  SortOptionPickerView.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import SwiftUI

struct SortOptionPickerView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Sort by")
                .foregroundStyle(Color("FGSecondary"))
                .font(.footnote)
            
            Picker("Sort by", selection: $viewModel.selectedSortOption) {
                Text("Name").tag(SortOptions.name)
                Text("Cuisine").tag(SortOptions.cuisine)
            }
            .tint(Color("FGPrimary"))
            .pickerStyle(MenuPickerStyle())
            .padding(12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color("ButtonBGColor"))
            )
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 4)
            .padding(.horizontal)
            .onChange(of: viewModel.selectedSortOption) {
                viewModel.send(.sortBy(viewModel.selectedSortOption))
            }
        }
    }
}
