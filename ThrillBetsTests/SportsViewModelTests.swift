//
//  SportsViewModelTests.swift
//  KaizenTests
//
//  Created by Petko Todorov on 6/20/24.
//

import XCTest
@testable import ThrillBets

final class SportsViewModelTests: XCTestCase {

    var sportsServiceMock: SportsServiceMock!
    var viewModel: SportsViewModel!

    override func setUpWithError() throws {
        sportsServiceMock = SportsServiceMock()
        viewModel = SportsViewModel(sportsService: sportsServiceMock)
    }

    override func tearDownWithError() throws {
        sportsServiceMock = nil
        viewModel = nil
    }

    func testLoadSportsSuccess() async throws {
        // Given
        let expectedSports = [Sport(id: "123", name: "Football", activeEvents: []),
                              Sport(id: "234", name: "Basketball", activeEvents: [])]
        sportsServiceMock.result = .success(expectedSports)

        // When
        try await viewModel.load()

        // Then
        XCTAssertEqual(viewModel.numberOfSections(), expectedSports.count)
        XCTAssertEqual(viewModel.sportSection(at: 0).sport.name, "Football")
        XCTAssertEqual(viewModel.sportSection(at: 1).sport.name, "Basketball")
    }

    func testLoadSportsFailure() async {
        // Given
        let expectedError = NSError(domain: "TestError", code: 1, userInfo: nil)
        sportsServiceMock.result = .failure(expectedError)

        do {
            // When
            try await viewModel.load()
            XCTFail("Expected error to be thrown")
        } catch {
            // Then
            XCTAssertEqual(error as NSError, expectedError)
        }
    }

    func testNumberOfSections() async throws {
        // Given
        let expectedSports = [Sport(id: "123", name: "Football", activeEvents: []),
                              Sport(id: "234", name: "Basketball", activeEvents: [])]
        sportsServiceMock.result = .success(expectedSports)

        // When
        try await viewModel.load()

        // Then
        XCTAssertEqual(viewModel.numberOfSections(), 2)
    }

    func testSportSectionAtIndex() async throws {
        // Given
        let expectedSports = [Sport(id: "123", name: "Football", activeEvents: []),
                              Sport(id: "234", name: "Basketball", activeEvents: [])]
        sportsServiceMock.result = .success(expectedSports)

        // When
        try await viewModel.load()

        // Then
        XCTAssertEqual(viewModel.sportSection(at: 0).sport.name, "Football")
        XCTAssertEqual(viewModel.sportSection(at: 1).sport.name, "Basketball")
    }

}
