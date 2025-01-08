//
//  MockImagesCacheManager.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 06/01/25.
//

import XCTest
@testable import Recipes

class MockImagesCacheManager: ImagesCacheManager {
    var imageToReturn: UIImage?
    var didSaveImage = false

    override func loadImageFromDisk(for url: URL) -> UIImage? {
        return imageToReturn
    }

    override func saveImageToDisk(_ image: UIImage, for url: URL) {
        didSaveImage = true
    }
}
