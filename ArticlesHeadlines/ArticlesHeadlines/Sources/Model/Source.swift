//
//  Source.swift
//  ArticlesHeadlines
//
//  Created by Hari on 28/10/2023.
//

import Foundation

// MARK: - Sources
struct Sources: Codable {
    var sources: [Source]?
}

// MARK: - Source
struct Source {
    var sourceId: String?
    var name: String?
    var url: String?
}

// MARK: - Codable
extension Source: Codable {
    private enum CodingKeys: String, CodingKey {
        case sourceId = "id"
        case name
        case url
    }
}
