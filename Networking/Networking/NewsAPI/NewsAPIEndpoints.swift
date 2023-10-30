//
//  NewsAPIEndpoints.swift
//  Networking
//
//  Created by Hari on 27/10/2023.
//

import Foundation

// MARK: - Endpoints
public enum NewsAPIEndpoints {
    public enum Headlines {
        case top(sources: String?)
    }
    
    public enum Sources {
        case all
    }
}

// MARK: - Headlines Endpoint
extension NewsAPIEndpoints.Headlines: Endpoint {
    public var host: String {
        return NewsAPIConstants.baseURL
    }
    
    public var path: String {
        return NewsAPIConstants.APIPath.topHeadlines
    }
    
    public var authorizationToken: String {
        return NewsAPIConstants.accessToken
    }
    
    public var requestType: RequestType {
        return .get
    }
    
    public var urlParams: [String : String]? {
        guard case let .top(sources) = self, let sources, !sources.isEmpty else {
            /// If no sources are provided, then set the default country
            return [ NewsAPIConstants.QueryParams.Key.country: NewsAPIConstants.QueryParams.Value.countryUS ]
        }
        /// If sources are selected, then set the sources
        return [ NewsAPIConstants.QueryParams.Key.sources: sources ]
    }
    
    public var body: [String : Any]? {
        return nil
    }
}

// MARK: - Sources Endpoint
extension NewsAPIEndpoints.Sources: Endpoint {
    public var host: String {
        return NewsAPIConstants.baseURL
    }
    
    public var path: String {
        return NewsAPIConstants.APIPath.sources
    }
    
    public var authorizationToken: String {
        return NewsAPIConstants.accessToken
    }
    
    public var requestType: RequestType {
        return .get
    }
    
    public var urlParams: [String : String]? {
        return [ NewsAPIConstants.QueryParams.Key.language: NewsAPIConstants.QueryParams.Value.languageEnglish ]
    }
    
    public var body: [String : Any]? {
        return nil
    }
}
