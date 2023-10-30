//
//  NetworkError.swift
//  
//
//  Created by Hari on 27/10/2023.
//

import Foundation

// MARK: - NetworkError
public enum NetworkError: LocalizedError {
    case invalidURL
    case invalidRequest
    case invalidRequestBody
    case invalidResponse
    case invalidStatusCode(statusCode: Int)
    case decodingError
    case unknownError

    public var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL string is invalid."
        case .invalidRequest:
            return "URL request creation failed."
        case .invalidRequestBody:
            return "The request body is invalid."
        case .invalidResponse:
            return "The server returned an invalid response."
        case .invalidStatusCode(let statusCode):
            return "The request failed with status code \(statusCode)."
        case .decodingError:
            return "The request body is invalid."
        case .unknownError:
            return "Unknown Error."
        }
    }
}
