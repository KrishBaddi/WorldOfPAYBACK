//
//  MockAPIManager.swift
//  WorldOfPAYBACKTests
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import Foundation
import Combine
@testable import WorldOfPAYBACK

class MockAPIManager: APIManagerProtocol {
    var response: AnyPublisher<PBTransactions, Error>?
    
    func fetchGitHubObjects<T: Codable>(modelType: T.Type,
                                        endpoint: APIEndpoint,
                                        customParams: [String: String]) -> AnyPublisher<T, Error> {
        guard let response = response as? AnyPublisher<T, Error> else {
                   return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
               }
        return response
    }
}
