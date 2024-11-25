//
//  ApiClientMock.swift
//  KaizenTests
//
//  Created by Petko Todorov on 6/20/24.
//

import Foundation
@testable import ThrillBets

class ApiClientMock: ApiClientProtocol {

    var result: Result<[Sport], Error>?

    func request<T>(endpoint: ThrillBets.Endpoint) async throws -> T where T : Decodable {
        switch result {
        case .success(let sports as T):
            return sports
        case .failure(let error):
            throw error
        case .none, .some(.success(_)):
            throw NSError(domain: "MockApiClientError", code: -1, userInfo: nil)
        }
    }

}
