//
//  ImagesCacheManager.swift
//  Recipes
//
//  Created by Hugo Sevilla Gómez Llanos on 14/12/24.
//

import SwiftUI

class ImagesCacheManager {
    static let shared = ImagesCacheManager()

    private let cacheDirectory: URL = {
        let paths = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return paths[0]
    }()

    public init() {}

    func loadImageFromDisk(for url: URL) -> UIImage? {
        let filePath = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        return UIImage(contentsOfFile: filePath.path)
    }

    func saveImageToDisk(_ image: UIImage, for url: URL) {
        let filePath = cacheDirectory.appendingPathComponent(url.lastPathComponent)
        guard let data = image.jpegData(compressionQuality: 1) else { return }
        try? data.write(to: filePath)
    }

    func clearDiskCache() {
        try? FileManager.default.removeItem(at: cacheDirectory)
        try? FileManager.default.createDirectory(at: cacheDirectory, withIntermediateDirectories: true)
    }
}
