//
//  RecipeFetcherTests.swift
//  RecipeFetcherTests
//
//  Created by Hugo Sevilla Gómez Llanos on 09/12/24.
//

import XCTest
@testable import Recipes

@MainActor
class RecipeFetcherTests: XCTestCase {
    
    func test_FetchRecipes_ReturnsSuccess() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher()
        mockFetcher.recipesToReturn = [
            Recipe(
                cuisine: "Mexican",
                name: "Tacos",
                photo_url_small: nil,
                photo_url_large: nil,
                uuid: "1",
                source_url: nil,
                youtube_url: nil
            )
        ]
        
        var recipes: [Recipe] = []
        var fetchError: Error?
        
        // Act
        do {
            recipes = try await mockFetcher.fetchRecipes(from: URL(string: "https://test.com")!)
        } catch {
            fetchError = error
        }
        
        // Assert
        XCTAssertNil(fetchError)
        XCTAssertEqual(recipes.count, 1)
        XCTAssertEqual(recipes.first?.name, "Tacos")
    }
    
    func test_FetchRecipes_ReturnsError() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher()
        mockFetcher.errorToReturn = NSError(domain: "TestError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network failure"])
        
        var fetchError: Error?
        
        // Act
        do {
            _ = try await mockFetcher.fetchRecipes(from: URL(string: "https://test.com")!)
        } catch {
            fetchError = error
        }
        
        // Assert
        XCTAssertNotNil(fetchError)
        XCTAssertEqual((fetchError as? NSError)?.domain, "TestError")
    }
    
    func test_LoadRecipes_SetsEmptyOnFailure() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher()
        mockFetcher.errorToReturn = NSError(domain: "TestError", code: -1, userInfo: nil)
        let viewModel = RecipesViewModel(recipeFetcher: mockFetcher)

        // Act
        await viewModel.loadRecipes(url: URL(string: "https://test.com")!)

        // Assert
        XCTAssertTrue(viewModel.recipes.isEmpty)
    }
    
    func test_ClearRecipes_EmptiesRecipes() {
        // Arrange
        let viewModel = RecipesViewModel()
        viewModel.recipes = [
            Recipe(cuisine: "Mexican", name: "Tacos", photo_url_small: nil, photo_url_large: nil, uuid: "1", source_url: nil, youtube_url: nil)
        ]
        
        // Act
        viewModel.clearRecipes()
        
        // Assert
        XCTAssertTrue(viewModel.recipes.isEmpty)
    }

    func test_SaveAndLoadImageFromDisk() {
        // Arrange
        let cacheManager = ImagesCacheManager.shared
        let mockImage = UIImage(systemName: "photo")!
        let mockURL = URL(string: "https://test.com/image.jpg")!
        
        // Act
        cacheManager.saveImageToDisk(mockImage, for: mockURL)
        let loadedImage = cacheManager.loadImageFromDisk(for: mockURL)
        
        // Assert
        XCTAssertNotNil(loadedImage, "Image should be loaded from disk")
    }

    func test_FetchImage_ReturnsImage() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher()
        let mockImage = UIImage(named: "MockImage")
        
        do {
            // Act
            let fetchedImage = try await mockFetcher.fetchImage(for: URL(string: "https://test.com/image.jpg")!)
            
            // Assert
            XCTAssertEqual(fetchedImage, mockImage)
        } catch {
            XCTFail("Expected image, but got error: \(error)")
        }
    }
    
    func test_FetchImage_ReturnsNilOnError() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher()
        mockFetcher.errorToReturn = NSError(domain: "ImageError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Failed to load image"])
        
        do {
            // Act
            let fetchedImage = try await mockFetcher.fetchImage(for: URL(string: "https://test.com/image.jpg")!)
            
            // Assert
            XCTAssertNil(fetchedImage)
        } catch let error as NSError {
            // Assert that no image is returned on error
            XCTAssertEqual(error.domain, "ImageError")
        }
    }
    
    func test_ChangingAPI_UpdatesSelectedAPI() async {
        // Arrange
        let mockFetcher = MockRecipeFetcher()
        mockFetcher.errorToReturn = NSError(domain: "Malformed Error", code: -1, userInfo: nil)
        
        // Act
        do {
            _ = try await mockFetcher.fetchRecipes(from: APIURLs.malformedAPI)
        } catch let error as NSError {
        // Assert
            XCTAssertEqual(error.domain, "Malformed Error")
            XCTAssertEqual(error.code, -1)
        }
    }
}
