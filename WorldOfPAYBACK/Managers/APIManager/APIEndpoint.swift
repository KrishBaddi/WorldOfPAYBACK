//
//  APIEndpoint.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 18/04/2023.
//

import Foundation

enum APIEndpoint {
    case getTransactions
    // Add more cases for other endpoints
    
    var path: String {
        switch self {
        case .getTransactions:
            return "/transactions"
        }
    }
    
    var httpMethod: String {
        switch self {
        case .getTransactions:
            return "GET"
        }
    }
}
