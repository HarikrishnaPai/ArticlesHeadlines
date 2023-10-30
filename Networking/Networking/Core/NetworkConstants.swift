//
//  NetworkConstants.swift
//  Networking
//
//  Created by Hari on 27/10/2023.
//

import Foundation

// MARK: - Network Constants
enum NetworkConstants {
    static let httpsScheme = "https"
    
    enum Header {
        enum Key {
            static let contentType = "Content-Type"
            static let authorization = "Authorization"
        }
        
        enum Value {
            static let contentTypeJson = "application/json"
        }
    }
}
