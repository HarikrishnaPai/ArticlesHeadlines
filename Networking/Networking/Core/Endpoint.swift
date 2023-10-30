//
//  Endpoint.swift
//  Networking
//
//  Created by Hari on 27/10/2023.
//

import Foundation

// MARK: - Endpoint
public protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var authorizationToken: String { get }
    var requestType: RequestType { get }
    var urlParams: [String: String]? { get }
    var body: [String: Any]? { get }
}

extension Endpoint {
    public var scheme: String {
        return NetworkConstants.httpsScheme
    }
}

// MARK: - Public Methods
extension Endpoint {
    func createURLRequest() throws -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        if let urlParams, !urlParams.isEmpty {
            urlComponents.queryItems = urlParams.map { URLQueryItem(name: $0, value: $1) }
        }

        guard let url = urlComponents.url else { throw NetworkError.invalidURL }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = requestType.rawValue
        urlRequest.setValue(NetworkConstants.Header.Value.contentTypeJson, forHTTPHeaderField: NetworkConstants.Header.Key.contentType)
        urlRequest.setValue(authorizationToken, forHTTPHeaderField: NetworkConstants.Header.Key.authorization)

        if let body {
            do {
                urlRequest.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
            } catch {
                throw NetworkError.invalidRequestBody
            }
        }
        return urlRequest
    }
}
