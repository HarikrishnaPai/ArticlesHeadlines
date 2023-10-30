//
//  Article.swift
//  ArticlesHeadlines
//
//  Created by Hari on 27/10/2023.
//

import Foundation

// MARK: - Articles
struct Articles: Codable {
    var articles: [Article]?
}

// MARK: - Article
struct Article: Codable {
    var title: String?
    var description: String?
    var author: String?
    var url: String?
    var urlToImage: String?
}
