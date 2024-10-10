//
//  RecipeViewModel.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import Foundation
import UIKit

enum SortOptions {
    case name
    case cuisine
}

class RecipeViewModel: ObservableObject {

    enum LoadingState: Equatable {
        case initial
        case loading
        case loaded
        case error(String)
    }
    
    enum Action {
        case sortBy(SortOptions)
        case filterByCuisine(String)
        case search(String)
        case openWebUrl(String)
    }
    
    // MARK: Properties
    @Published var recipes: [Recipe] = []
    @Published var searchText: String = ""
    @Published var selectedCuisine: String = "All"
    @Published var cuisines: [String] = ["All"]
    @Published var loadingState: LoadingState = .initial
    @Published var selectedSortOption: SortOptions = .name
    @Published var sortedRecipes: [Recipe] = []
    
    private let service: RecipeServiceProtocol
    
    // MARK: Initializer 
    init(service: RecipeServiceProtocol = RecipeService.shared) {
        self.service = service
        Task {
            await fetchRecipes()
        }
    }
    
    func refreshRecipes() async {
        await fetchRecipes()
    }
    
    @MainActor
    func fetchRecipes() async {
        loadingState = .loading
        
        do {
            let data = try await service.fetchRecipeData(urlString: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
            self.recipes = data
            self.cuisines = Array(Set(data.map { $0.cuisine })).sorted()
            self.cuisines.insert("All", at: 0)
            
            getSortedRecipes(by: selectedSortOption)
            loadingState = .loaded
        } catch {
            print("Failed to load recipes: \(error.localizedDescription)")
            loadingState = .error("Failed to load recipes: \(error.localizedDescription)")
        }
    }

    func send(_ action: Action) {
        switch action {
        case .sortBy(let sortOption):
            selectedSortOption = sortOption
            getSortedRecipes(by: sortOption)
        case .filterByCuisine(let cuisine):
            selectedCuisine = cuisine
            getSortedRecipes(by: selectedSortOption)
        case .search(let query):
            searchText = query
            getSortedRecipes(by: selectedSortOption)
        case .openWebUrl(let urlString):
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func getFilteredRecipes() -> [Recipe] {
        return recipes.filter { recipe in
            (selectedCuisine == "All" || recipe.cuisine == selectedCuisine) &&
            (searchText.isEmpty || recipe.name.lowercased().contains(searchText.lowercased()))
        }
    }
    
    private func getSortedRecipes(by sortOption: SortOptions) {
        let filteredRecipes = getFilteredRecipes()
        
        switch sortOption {
        case .name:
            sortedRecipes = filteredRecipes.sorted(by: { $0.name < $1.name })
        case .cuisine:
            sortedRecipes = filteredRecipes.sorted(by: { $0.cuisine < $1.cuisine })
        }
    }
}
