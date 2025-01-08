//
//  Untitled.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 06/01/25.
//

import XCTest
@testable import Recipes

class ImagesCacheManagerTests: XCTestCase {
    func test_FetchImage_UsesCacheIfAvailable() async {
        // Arrange
        let mockCacheManager = MockImagesCacheManager()
        let mockFetcher = RecipeFetcher(imagesCacheManager: mockCacheManager)
        mockCacheManager.imageToReturn = UIImage(systemName: "star")
        
        
        // Act
        let fetchedImage = try? await mockFetcher.fetchImage(for: URL(string: "https://test.com/image.jpg")!)
        
        // Assert
        XCTAssertNotNil(fetchedImage)
        XCTAssertEqual(fetchedImage, mockCacheManager.imageToReturn)
        XCTAssertFalse(mockCacheManager.didSaveImage)
    }
    
    func test_FetchImage_SavesToCacheAfterDownload() async {
        // Arrange
        let mockCacheManager = MockImagesCacheManager()
        let mockSession = MockNetworkSession()
        
        let mockImage = UIImage(systemName: "photo")!
        let mockData = mockImage.jpegData(compressionQuality: 1)!
        
        mockSession.mockData = mockData
        mockSession.mockResponse = HTTPURLResponse(
            url: URL(
                string: "https://test.com/image.jpg")!,
            statusCode: 200, httpVersion: nil,
            headerFields: nil
        )
        
        let mockFetcher = RecipeFetcher(imagesCacheManager: mockCacheManager, session: mockSession)
        let mockURL = URL(string: "https://test.com/image.jpg")!
        
        // Act
        _ = try? await mockFetcher.fetchImage(for: mockURL)
        
        // Assert
        XCTAssertTrue(mockCacheManager.didSaveImage)
    }
}
