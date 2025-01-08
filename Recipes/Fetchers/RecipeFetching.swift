//
//  RecipeFetching.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 14/12/24.
//

import SwiftUI

protocol RecipeFetching {
    func fetchRecipes(from url: URL) async throws -> [Recipe]
    func fetchImage(for url: URL) async throws -> UIImage?
}
