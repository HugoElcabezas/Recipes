//
//  RecipeViewModel.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 14/12/24.
//

import Foundation

@MainActor
class RecipesViewModel: ObservableObject {
    @Published var recipes: [Recipe] = []
    private var recipeFetcher: RecipeFetching

    init(recipeFetcher: RecipeFetching = RecipeFetcher()) {
        self.recipeFetcher = recipeFetcher
    }

    func loadRecipes(url: URL) async {
        do {
            let recipes = try await recipeFetcher.fetchRecipes(from: url)
            self.recipes = recipes
        } catch {
            print("Error loading recipes: \(error)")
            self.recipes = []
        }
    }

    func clearRecipes() {
        recipes.removeAll()
    }
}
