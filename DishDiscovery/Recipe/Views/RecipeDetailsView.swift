//
//  RecipeDetailsView.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct RecipeDetailsView: View {
    @ObservedObject var viewModel: RecipeViewModel
    let recipe: Recipe
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 10) {
                if let largeImageUrl = URL(string: recipe.photoUrlLarge ?? "") {
                    WebImage(url: largeImageUrl) { image in
                        image
                    } placeholder: {
                        Image(systemName: "photo")
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 250)
                    .cornerRadius(15)
                    .clipped()
                    .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 10)

                }
                
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                Text("Cuisine: \(recipe.cuisine)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                    .padding(.horizontal)
                
                if let sourceUrl = recipe.sourceUrl,
                   let youtubeUrl = recipe.youtubeUrl,
                   let videoId = extractYouTubeID(from: youtubeUrl) {
                    VStack(alignment: .center, spacing: 10) {
                        Button {
                            viewModel.send(.openWebUrl(sourceUrl))
                        } label: {
                            HStack {
                                Spacer()
                                Text("Visit Recipe Website")
                                    .font(.subheadline)
                                Spacer()
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(Color("ButtonBGColor"))
                            )
                            .foregroundStyle(Color("FGPrimary"))
                            .cornerRadius(12)
                        }
                        .padding(20)
                        
                        YouTubeVideoPlayerView(videoId: videoId)
                            .frame(height: 300)
                            .cornerRadius(15)
                            .padding(.horizontal)
                    }
                }
            }
            .padding(20)
        }
        .background(Color("BackgroundColor"))
    }
    
    /// Method from https://stackoverflow.com/a/41166559
    func extractYouTubeID(from youtubeUrl: String) -> String? {
        return URLComponents(string: youtubeUrl)?.queryItems?.first(where: { $0.name == "v" })?.value
    }
}
