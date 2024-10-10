//
//  RecipeService.swift
//  DishDiscovery
//
//  Created by Myat Thu Ko on 10/10/24.
//

import Alamofire
import Foundation
import SDWebImage

struct RecipeResponse: Codable {
    let recipes: [Recipe]
}

protocol RecipeServiceProtocol {
    func fetchRecipeData(urlString: String) async throws -> [Recipe]
    func loadImage(from url: URL)
}

enum RecipeServiceError: Error, Equatable {
    case emptyData
    case malformedData
    case networkError(Error)
    case invalidURL
    
    static func == (lhs: RecipeServiceError, rhs: RecipeServiceError) -> Bool {
        switch (lhs, rhs) {
        case (.emptyData, .emptyData),
            (.malformedData, .malformedData),
            (.invalidURL, .invalidURL):
            return true
        case (.networkError(let lhsError), .networkError(let rhsError)):
            return lhsError.localizedDescription == rhsError.localizedDescription
        default:
            return false
        }
    }
}

final class RecipeService: RecipeServiceProtocol {
    static let shared = RecipeService()

    private init() {}

    func fetchRecipeData(urlString: String) async throws -> [Recipe] {
        guard let url = URL(string: urlString) else {
            throw RecipeServiceError.invalidURL
        }

        do {
            // Decode the response as RecipeResponse
            let recipeResponse: RecipeResponse = try await withCheckedThrowingContinuation { continuation in
                AF.request(url).responseDecodable(of: RecipeResponse.self, decoder: JSONDecoder()) { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: RecipeServiceError.networkError(error))
                    }
                }
            }

            let recipes = recipeResponse.recipes

            await withTaskGroup(of: Void.self) { group in
                for recipe in recipes {
                    group.addTask {
                        if let photoUrl = recipe.photoUrlLarge, let url = URL(string: photoUrl) {
                            self.loadImage(from: url) // Use loadImage method here
                        }
                    }
                }
            }

            return recipes

        } catch let error as RecipeServiceError {
            print("Failed to fetch recipes: \(error)")
            throw error
        } catch is DecodingError {
            print("Failed to decode recipe data")
            throw RecipeServiceError.malformedData
        } catch {
            print("An unexpected error occurred: \(error)")
            throw RecipeServiceError.networkError(error)
        }
    }

    func loadImage(from url: URL) {
        SDWebImageManager.shared.loadImage(
            with: url,
            options: .highPriority,
            progress: nil,
            completed: { _, _, error, _, _, _ in
                if let error = error {
                    print("Failed to load image: \(error.localizedDescription)")
                }
            }
        )
    }
}
