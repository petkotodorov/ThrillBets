//
//  SportsServiceTests.swift
//  KaizenTests
//
//  Created by Petko Todorov on 6/20/24.
//

import XCTest
@testable import ThrillBets

final class SportsServiceTests: XCTestCase {

    var apiClientMock: ApiClientMock!
    var sportsService: SportsService!

    override func setUpWithError() throws {
        apiClientMock = ApiClientMock()
        sportsService = SportsService(apiClient: apiClientMock)
    }

    override func tearDownWithError() throws {
        apiClientMock = nil
        sportsService = nil
    }

    func testGetSportsSuccess() async throws {
        // Given
        let expectedSports = [Sport(id: "123", name: "Football", activeEvents: []),
                              Sport(id: "234", name: "Basketball", activeEvents: [])]
        apiClientMock.result = .success(expectedSports)

        // When
        let sports = try await sportsService.getSports()

        // Then
        XCTAssertEqual(sports, expectedSports)
    }

    func testGetSportsFailure() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        apiClientMock.result = .failure(expectedError)

        do {
            // When
            _ = try await sportsService.getSports()
            XCTFail("Expected error to be thrown")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, expectedError)
        }
    }

}
