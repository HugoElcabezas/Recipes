//
//  MockRecipeFetcher.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 14/12/24.
//

import XCTest
@testable import Recipes

class MockRecipeFetcher: RecipeFetching {
    var recipesToReturn: [Recipe] = []
    var errorToReturn: Error?

    func fetchRecipes(from url: URL) async throws -> [Recipe] {
        if let error = errorToReturn {
            throw error
        }
        return recipesToReturn
    }

    func fetchImage(for url: URL) async throws -> UIImage? {
        return UIImage(named: "MockImage")
    }
}
