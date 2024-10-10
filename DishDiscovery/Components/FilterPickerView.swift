//
//  FilterPickerView.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import SwiftUI

struct FilterPickerView: View {
    @ObservedObject var viewModel: RecipeViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Filter")
                .foregroundStyle(Color("FGSecondary"))
                .font(.footnote)
            
            Picker("Cuisine", selection: $viewModel.selectedCuisine) {
                ForEach(viewModel.cuisines, id: \.self) { cuisine in
                    Text(cuisine)
                }
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
            .onChange(of: viewModel.selectedCuisine) {
                viewModel.send(.filterByCuisine(viewModel.selectedCuisine))
            }
        }
    }
}
