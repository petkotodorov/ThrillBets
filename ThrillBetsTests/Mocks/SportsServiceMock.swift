//
//  SportsServiceMock.swift
//  KaizenTests
//
//  Created by Petko Todorov on 6/20/24.
//

import Foundation
@testable import ThrillBets

class SportsServiceMock: SportsServiceProtocol {
    var result: Result<[Sport], Error>?

    func getSports() async throws -> [Sport] {
        switch result {
        case .success(let sports):
            return sports
        case .failure(let error):
            throw error
        case .none:
            throw NSError(domain: "MockSportsServiceError", code: -1, userInfo: nil)
        }
    }
}


