//
//  SearchBarView.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import SwiftUI

struct SearchBarView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @State private var fontColor = Color("FGSecondary")
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(Color("FGPrimary"))
                .padding(.leading, 10)
            
            TextField("Search recipes...", text: $viewModel.searchText)
                .foregroundStyle(fontColor)
                .padding(10)
                .background(Color.clear)
                .onChange(of: viewModel.searchText) {
                    viewModel.send(.search(viewModel.searchText))
                    fontColor = Color("FGPrimary")
                }
                .overlay(
                    HStack {
                        Spacer()
                        if !viewModel.searchText.isEmpty {
                            Button(action: {
                                viewModel.searchText = ""
                                viewModel.send(.search(""))
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundStyle(Color("FGPrimary"))
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                )
        }
        .padding(10)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("ButtonBGColor"))
        )
        .cornerRadius(12)
    }
}
