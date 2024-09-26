//
//  NetworkManager.swift
//  Recipes
//
//  Created by Miha on 24/09/2024.
//

import Foundation

enum NetworkError: Error {
    case invalidUrl
    case sessionError(error: Error)
    case missingResponse
    case badResponse(response: URLResponse?)
}

class NetworkManager {
    static let shared = NetworkManager()
    private init() { }
    
    private let baseURL: String = "https://api.edamam.com/api/recipes/v2"
        
    private let appId: String = "b25887c3"
    private let appKey: String = "98845d5aff595ccd3339711c0fa5ab8e"
    
    /**
     Get data from server
     - Parameter searchText: Text to search recipes by
     - Returns: Recipes list
     */
    func fetchData(searchText: String) async throws -> [Hit] {
        guard var components = URLComponents(string: baseURL) else {
            throw NetworkError.invalidUrl
        }
        
        components.queryItems = [
            URLQueryItem(name: "type", value: "public"),
            URLQueryItem(name: "app_id", value: appId),
            URLQueryItem(name: "app_key", value: appKey),
            URLQueryItem(name: "q", value: searchText)
        ]
        
        guard let url = components.url else {
            print("Error with url fetching data")
            throw NetworkError.invalidUrl
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        if let httpResponse = response as? HTTPURLResponse,
           (200...299).contains(httpResponse.statusCode) {
            guard let response = try? JSONDecoder().decode(Response.self, from: data) else
            {
                throw NetworkError.missingResponse
            }
            return response.hits
        } else {
            print("Error, unexpected status code: \(response)")
            throw NetworkError.badResponse(response: response)
        }
    }
}
