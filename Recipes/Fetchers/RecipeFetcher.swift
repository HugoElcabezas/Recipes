//
//  RecipeFetcher.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 14/12/24.
//

import SwiftUI

class RecipeFetcher: RecipeFetching {
    private let imagesCacheManager: ImagesCacheManager
    private let session: NetworkSessionProtocol
    
    init(imagesCacheManager: ImagesCacheManager = .shared, session: NetworkSessionProtocol = NetworkSession()) {
        self.imagesCacheManager = imagesCacheManager
        self.session = session
    }
    
    func fetchRecipes(from url: URL) async throws -> [Recipe] {
        let (data, _) = try await session.data(from: url)
        do {
            let decodedResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
            return decodedResponse.recipes
        } catch {
            throw error
        }
    }
    
    func fetchImage(for url: URL) async throws -> UIImage? {
        if let cachedImage = imagesCacheManager.loadImageFromDisk(for: url) {
            return cachedImage
        }
        
        let (data, _) = try await session.data(from: url)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])
        }
        
        imagesCacheManager.saveImageToDisk(image, for: url)
        return image
    }
}
