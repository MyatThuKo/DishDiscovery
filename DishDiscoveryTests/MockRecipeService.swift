//
//  MockRecipeService.swift
//  DishDiscoveryTests
//
//  Created by Myat Thu Ko on 10/10/24.
//

import Foundation

@testable import DishDiscovery

final class MockRecipeService: RecipeServiceProtocol {
    enum TestCase {
        case malformedData
        case emptyData
        case validData([Recipe])
    }
    
    private let testCase: TestCase
    
    init(testCase: TestCase) {
        self.testCase = testCase
    }
    
    func fetchRecipeData(urlString: String) async throws -> [Recipe] {
        switch testCase {
        case .malformedData:
            throw RecipeServiceError.malformedData
        case .emptyData:
            throw RecipeServiceError.emptyData
        case .validData(let recipes):
            return recipes
        }
    }
    
    func loadImage(from url: URL) {
        // Do nothing or simulate a successful image load.
    }
}
