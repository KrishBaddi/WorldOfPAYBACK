//
//  APIManager.swift
//  WorldOfPAYBACK
//
//  Created by Ramkrishna Baddi on 15/04/2023.
//

import Foundation
import Combine

protocol APIManagerProtocol {
    func fetchGitHubObjects<T: Codable>(modelType: T.Type,
                                        endpoint: APIEndpoint,
                                        customParams: [String: String]) -> AnyPublisher<T, Error>
    
    // Mocking purpose
    var response: AnyPublisher<PBTransactions, Error>? { get set }
    
}

class APIManager: APIManagerProtocol {
    var response: AnyPublisher<PBTransactions, Error>?
    
    let baseURL = "https://api.payback.com"
    var isFetching = false
    
    static let shared = APIManager()
    
    private var accessToken: String?
    
    private init() {}
    
    func setAccessToken(_ token: String?) {
        accessToken = token
    }
    
    
    // Fetch GitHub users with pagination and dynamically determine page size
    func fetchGitHubObjects<T: Codable>(modelType: T.Type, endpoint: APIEndpoint, customParams: [String: String] = [:]) -> AnyPublisher<T, Error> {
        guard !isFetching else {
            return Fail(error: APIError.requestInProgress).eraseToAnyPublisher()
        }
        isFetching = true
        
        // Create URL components for API request
        var components = URLComponents(string: "\(baseURL)\(String(describing: endpoint.path))")
        
        // Add custom parameters to the URL query parameters
        var queryItems: [URLQueryItem] = []
        for (key, value) in customParams {
            let queryItem = URLQueryItem(name: key, value: value)
            queryItems.append(queryItem)
        }
        components?.queryItems = queryItems
        
        guard let url = components?.url else {
            print("Failed to create URL for (\(T.self) objects API")
            isFetching = false
            return Fail(error: APIError.invalidURL).eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        
        print(request.debugDescription)
        
        // Set up URLSession with a custom configuration
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        return session.dataTaskPublisher(for: request)
            .tryMap { [weak self] data, response in
                // Check if the response contains "Not Found" error
                guard let self = self,
                      let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.invalidResponse
                }
                
                // Check HTTP status code for error
                if !self.isSuccessStatusCode(httpResponse.statusCode) {
                    throw APIError.serverError(httpResponse.statusCode)
                }
                
                let decoder = JSONDecoder()
                let objects = try decoder.decode(T.self, from: data)
                
                // Increment current page number for next pagination
                self.isFetching = false
                
                return objects
            }
            .mapError { error -> Error in
                print("Failed to fetch \(T.self) objects: \(error.localizedDescription)")
                self.isFetching = false
                return error
            }
            .eraseToAnyPublisher()
    }
    
    
    // Custom utility method to check for successful HTTP status codes
    private func isSuccessStatusCode(_ statusCode: Int) -> Bool {
        return statusCode >= 200 && statusCode < 300
    }
}
