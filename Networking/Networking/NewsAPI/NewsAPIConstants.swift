//
//  NewsAPIConstants.swift
//  Networking
//
//  Created by Hari on 29/10/2023.
//

import Foundation

// MARK: - Network Constants
enum NewsAPIConstants {
    static let baseURL = "newsapi.org"
    static let accessToken = "6518ae6cbb5f4ce5b4c3d4efdc64e034"
    
    enum APIPath {
        static let topHeadlines = "/v2/top-headlines"
        static let sources = "/v2/top-headlines/sources"
    }
    
    enum QueryParams {
        enum Key {
            static let country = "country"
            static let sources = "sources"
            static let language = "language"
        }
        
        enum Value {
            static let countryUS = "us"
            static let languageEnglish = "en"
        }
    }
}
