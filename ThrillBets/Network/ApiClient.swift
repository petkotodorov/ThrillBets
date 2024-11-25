//
//  ApiClient.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/18/24.
//

import Foundation

/// Possible endpoints to be accessed
enum Endpoint: String {
    case sports
}

protocol ApiClientProtocol {
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T
}

/// Class, used for establishing the communication with the BE
final class ApiClient: ApiClientProtocol {

    // MARK: - Variables

    private let domain: String

    // MARK: - Initializers

    init(withDomain domain: String = "https://618d3aa7fe09aa001744060a.mockapi.io/api/") {
        self.domain = domain
    }

    // MARK: - Functionality
    
    /// Generic request function
    /// - Parameter endpoint: particular endpoint of the backend
    /// - Returns: Particular response, matching the generic requirements
    func request<T: Decodable>(endpoint: Endpoint) async throws -> T {
        let session = URLSession(configuration: .default)
        let url = URL(string: domain + endpoint.rawValue)!
        let request = URLRequest(url: url)

        let (data, _) = try await session.data(for: request)

        let response = try JSONDecoder().decode(T.self, from: data)

        return response
    }
}
