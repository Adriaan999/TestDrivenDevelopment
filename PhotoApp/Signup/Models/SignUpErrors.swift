//
//  SignUpErrors.swift
//  PhotoApp
//
//  Created by Adriaan van Schalkwyk on 2021/03/25.
//

import Foundation

enum SignUpErrors: LocalizedError, Equatable {
    case responseModelParsingError
    case invalidRequestURLStringError
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .responseModelParsingError, .invalidRequestURLStringError:
            return""
        }
    }
}
