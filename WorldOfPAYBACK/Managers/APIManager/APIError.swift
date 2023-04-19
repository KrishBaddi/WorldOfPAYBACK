//
//  APIError.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 19/04/2023.
//

import Foundation

// Define an enum for API errors
enum APIError: Error {
    case notFound
    case invalidResponse
    case invalidURL
    case serverError(NSInteger)
    case requestInProgress
    // Add more error cases as needed
    
    var errorMessage: String {
        switch self {
        case .serverError(let message): return "Server error(\(message)"
        default: return "Oops! Something went wrong. We're unable to fetch your transactions."
        }
    }
}
