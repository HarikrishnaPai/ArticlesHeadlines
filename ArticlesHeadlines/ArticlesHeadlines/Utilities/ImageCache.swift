//
//  ImageCache.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import UIKit

class ImageCache {
    
    // MARK: - Variables
    private var cache = NSCache<NSString, AnyObject>()

    // MARK: - Public Methods
    func cacheImage(_ image: UIImage, for url: String) {
        cache.setObject(image, forKey: url as NSString)
    }

    func image(for url: String) -> UIImage? {
        return cache.object(forKey: url as NSString) as? UIImage
    }
}
