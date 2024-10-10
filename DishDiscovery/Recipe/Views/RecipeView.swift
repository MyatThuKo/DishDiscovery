//
//  RecipeView.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeView: View {
    @ObservedObject var viewModel: RecipeViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 20) {
                ForEach(viewModel.sortedRecipes) { recipe in
                    NavigationLink(
                        destination: RecipeDetailsView(viewModel: viewModel, recipe: recipe)
                    ) {
                        RecipeRow(recipe: recipe)
                    }
                    .buttonStyle(PlainButtonStyle()) // Makes the NavigationLink look seamless
                    .padding(.horizontal)
                }
            }
            .padding(.top, 20)
        }
        // Add refreshable here for manual refresh of recipe list
        .refreshable {
            await viewModel.refreshRecipes()
        }
    }
}

struct RecipeRow: View {
    let recipe: Recipe
    
    var body: some View {
        HStack(spacing: 15) {
            // Use SDWebImage for better caching and lazy loading
            if let imageUrl = URL(string: recipe.photoUrlSmall ?? "") {
                WebImage(url: imageUrl) { image in
                    image
                } placeholder: {
                    Image(systemName: "photo")
                }
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(10)
                .clipped()
            }
            
            // Recipe name and cuisine
            VStack(alignment: .leading, spacing: 5) {
                Text(recipe.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(recipe.cuisine)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(Color("ButtonBGColor"))
        )
        .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 5)  // Subtle shadow
    }
}
