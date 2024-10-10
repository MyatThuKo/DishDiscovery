//
//  ContentView.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var viewModel = RecipeViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 10) {
                    Text("Dish Discovery")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(Color("ButtonBGColor"))
                        .padding(.top, 10)
                    
                    SearchBarView(viewModel: viewModel)
                    
                    HStack {
                        FilterPickerView(viewModel: viewModel)
                        
                        SortOptionPickerView(viewModel: viewModel)
                    }
                    
                    if viewModel.sortedRecipes.isEmpty {
                        Text("No recipes available")
                            .foregroundStyle(Color("FGPrimary"))
                            .padding()
                    } else {
                        RecipeView(viewModel: viewModel)
                    }
                }
                .padding(10)
            }
            .background(Color("BackgroundColor"))
            .navigationTitle("Dish Discovery")
            .toolbar(.hidden)
            .overlay(
                Group {
                    if viewModel.loadingState == .loading {
                        AnimatedTextView(text: "LOADING...", fontColor: .init(red: 31, green: 112, blue: 181))
                    }
                }
            )
            .refreshable {
                await viewModel.refreshRecipes()
            }
            .onAppear {
                Task {
                    try await viewModel.fetchRecipes()
                }
            }
        }
        .tint(Color("FGPrimary"))
    }
}
