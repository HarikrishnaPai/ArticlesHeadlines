//
//  NetworkManager.swift
//  Networking
//
//  Created by Hari on 27/10/2023.
//

import Foundation

public protocol NetworkManagerProtocol {
    func performRequest<T: Decodable>(for endpoint: Endpoint, 
                                      responseModel: T.Type) async throws -> T
}

public class NetworkManager: NetworkManagerProtocol {
    
    // MARK: - Variables
    private let session: URLSession
    
    // MARK: - Initialization
    public init(session: URLSession = .shared) {
        self.session = session
    }
}

// MARK: - Public Methods
extension NetworkManager {
    public func performRequest<T: Decodable>(for endpoint: Endpoint, 
                                             responseModel: T.Type) async throws -> T {
        let request: URLRequest
        do {
            request = try endpoint.createURLRequest()
        } catch {
            throw NetworkError.invalidRequest
        }
        print("Request URL: \(request.url?.absoluteString ?? "")")
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        guard httpResponse.statusCode == 200 else {
            throw NetworkError.invalidStatusCode(statusCode: httpResponse.statusCode)
        }
        let decoder = JSONDecoder()
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
