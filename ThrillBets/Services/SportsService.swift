//
//  SportsService.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/18/24.
//

import Foundation

/// Protocol, defining the required functionality for fetching sports
protocol SportsServiceProtocol {
    /// Initiates a request for retrieving of the sports and the corresponding events
    /// - Returns: a list of sports
    func getSports() async throws -> [Sport]
}

/// Service, responsible for fetching all sports
struct SportsService: SportsServiceProtocol {

    private let apiClient: ApiClientProtocol

    init(apiClient: ApiClientProtocol = ApiClient()) {
        self.apiClient = apiClient
    }

    func getSports() async throws -> [Sport] {
        return try await apiClient.request(endpoint: .sports)
    }
}
