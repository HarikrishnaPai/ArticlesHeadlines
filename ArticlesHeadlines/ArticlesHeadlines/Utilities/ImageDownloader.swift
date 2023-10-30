//
//  ImageDownloader.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

class ImageDownloader {
    
    // MARK: - Variables
    static let shared = ImageDownloader()
    private let imageCache = ImageCache()

    // MARK: - Initialization
    private init() {}

    // MARK: - Public Methods
    func downloadImage(from url: String) async throws -> UIImage? {
        guard let imageUrl = URL(string: url) else { return nil }
        if let cachedImage = imageCache.image(for: url) {
            return cachedImage
        }

        let data = try await downloadImageData(from: imageUrl)
        guard let image = UIImage(data: data) else {
            throw NSError(domain: "InvalidImageData", code: 0, userInfo: nil)
        }

        imageCache.cacheImage(image, for: url)
        return image
    }
    
    // MARK: - Private Methods
    private func downloadImageData(from url: URL) async throws -> Data {
        let request = URLRequest(url: url)
        let (data, _) = try await URLSession.shared.data(for: request)
        return data
    }
}
