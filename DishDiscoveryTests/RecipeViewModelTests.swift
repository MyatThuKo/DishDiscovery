//
//  RecipeViewModelTests.swift
//  DishDiscoveryTests
//
//  Created by Myat Thu Ko on 10/10/24.
//

import XCTest

@testable import DishDiscovery

final class RecipeViewModelTests: XCTestCase {
    
    var viewModel: RecipeViewModel!
    var mockService: MockRecipeService!
    
    let mockRecipes = [
        Recipe(
            cuisine: "Malaysian",
            name: "Apam Balik",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
            sourceUrl: "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
            uuid: "1",
            youtubeUrl: "https://www.youtube.com/watch?v=6R8ffRRJcrg"
        ),
        Recipe(
            cuisine: "British",
            name: "Apple & Blackberry Crumble",
            photoUrlLarge: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
            photoUrlSmall: "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
            sourceUrl: "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
            uuid: "2",
            youtubeUrl: "https://www.youtube.com/watch?v=4vhcOwVBDO4"
        )
    ]
    
    func testFetchRecipesSuccess() async {
        mockService = MockRecipeService(testCase: .validData(mockRecipes))
        viewModel = RecipeViewModel(service: mockService)
        
        await viewModel.fetchRecipes()
        
        XCTAssertEqual(viewModel.loadingState, .loaded, "Expected loading state to be 'loaded'.")
        XCTAssertEqual(viewModel.recipes.count, 2, "Should have fetched 2 recipes.")
        XCTAssertEqual(viewModel.sortedRecipes.count, 2, "Sorted recipes should match the number of fetched recipes.")
        XCTAssertEqual(viewModel.cuisines, ["All", "British", "Malaysian"], "Cuisines should include 'All', 'British', and 'Malaysian'.")
    }
    
    func testFetchRecipesError() async {
        mockService = MockRecipeService(testCase: .malformedData)
        viewModel = RecipeViewModel(service: mockService)
        
        await viewModel.fetchRecipes()
        
        if case let .error(message) = viewModel.loadingState {
            XCTAssertTrue(message.contains("Failed to load recipes"), "Expected error message in loading state.")
        } else {
            XCTFail("Expected error state but got \(viewModel.loadingState)")
        }
    }
}
