//
//  MockNetworkManager.swift
//  ArticlesHeadlinesTests
//
//  Created by Hari on 29/10/2023.
//

import XCTest
@testable import ArticlesHeadlines
@testable import Networking

class MockNetworkManager: NSObject, NetworkManagerProtocol {
    
    var performRequestCalledCount: Int = 0
    var requestEndpoint: Networking.Endpoint?
    var stubbedResult: Any?

    func addStubbedResult<T: Decodable>(_ result: T) {
        stubbedResult = result
    }
    
    func performRequest<T: Decodable>(for endpoint: Networking.Endpoint,
                                      responseModel: T.Type) async throws -> T {
        performRequestCalledCount += 1
        requestEndpoint = endpoint
        return stubbedResult as! T
    }
}
