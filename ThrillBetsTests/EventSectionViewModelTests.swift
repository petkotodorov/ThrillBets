//
//  EventSectionViewModelTests.swift
//  KaizenTests
//
//  Created by Petko Todorov on 6/20/24.
//

import XCTest
@testable import ThrillBets

final class EventSectionViewModelTests: XCTestCase {

    var viewModel: EventSectionViewModel!

    let mockEvents = [
        Event(sportId: "1", eventId: "1", name: "Event 1", startTime: 1000),
        Event(sportId: "1", eventId: "2", name: "Event 2", startTime: 2000),
        Event(sportId: "1", eventId: "3", name: "Event 3", startTime: 3000),
        Event(sportId: "1", eventId: "4", name: "Event 4", startTime: 4000),
        Event(sportId: "1", eventId: "5", name: "Event 5", startTime: 5000),
        Event(sportId: "1", eventId: "6", name: "Event 6", startTime: 6000),
        Event(sportId: "1", eventId: "7", name: "Event 7", startTime: 7000)
    ]

    override func setUpWithError() throws {
        viewModel = EventSectionViewModel(events: mockEvents)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testNumberOfItems() {
        // Given

        // When
        let numberOfItems = viewModel.numberOfItems()

        // Then
        XCTAssertEqual(numberOfItems, mockEvents.count)
    }

    func testItemAtIndex() {
        // Given

        // When
        let item0 = viewModel.item(at: 0)
        let item1 = viewModel.item(at: 1)

        // Then
        XCTAssertEqual(item0.event, mockEvents[0])
        XCTAssertEqual(item1.event, mockEvents[1])
    }

    func testMarkFavorite() {
        // Given
        var updatedIndexes: [(Int, Int)] = []
        viewModel.updateIndexes = { from, to in
            updatedIndexes.append((from, to))
        }

        // When
        viewModel.markFavorite(at: 2) // add item at index 2 to favorites
        XCTAssertTrue(viewModel.item(at: 0).isFavorite)
        XCTAssertFalse(viewModel.item(at: 1).isFavorite)
        XCTAssertEqual(viewModel.item(at: 0).event, mockEvents[2])

        viewModel.markFavorite(at: 4) // add item at index 4 to favorites
        XCTAssertTrue(viewModel.item(at: 0).isFavorite)
        XCTAssertTrue(viewModel.item(at: 1).isFavorite)
        XCTAssertFalse(viewModel.item(at: 2).isFavorite)
        XCTAssertEqual(viewModel.item(at: 0).event, mockEvents[4])
        XCTAssertEqual(viewModel.item(at: 1).event, mockEvents[2])
        XCTAssertEqual(viewModel.item(at: 2).event, mockEvents[0])

        viewModel.markFavorite(at: 2) // add item at index 2 to favorites
        XCTAssertTrue(viewModel.item(at: 0).isFavorite)
        XCTAssertTrue(viewModel.item(at: 1).isFavorite)
        XCTAssertTrue(viewModel.item(at: 2).isFavorite)
        XCTAssertEqual(viewModel.item(at: 0).event, mockEvents[0])
        XCTAssertEqual(viewModel.item(at: 1).event, mockEvents[4])
        XCTAssertEqual(viewModel.item(at: 2).event, mockEvents[2])

        viewModel.markFavorite(at: 1) // remove item at index 1 from favorites
        XCTAssertTrue(viewModel.item(at: 0).isFavorite)
        XCTAssertTrue(viewModel.item(at: 1).isFavorite)
        XCTAssertFalse(viewModel.item(at: 2).isFavorite)
        XCTAssertEqual(viewModel.item(at: 0).event, mockEvents[0])
        XCTAssertEqual(viewModel.item(at: 1).event, mockEvents[2])
        XCTAssertEqual(viewModel.item(at: 2).event, mockEvents[1])

        // Verify updateIndexes calls
        XCTAssertEqual(updatedIndexes.count, 4)
        XCTAssertEqual(updatedIndexes[0].0, 2)  // Event 3 to front
        XCTAssertEqual(updatedIndexes[0].1, 0)
        XCTAssertEqual(updatedIndexes[1].0, 4)  // Event 5 to front
        XCTAssertEqual(updatedIndexes[1].1, 0)
        XCTAssertEqual(updatedIndexes[2].0, 2)  // Event 1 to front
        XCTAssertEqual(updatedIndexes[2].1, 0)
        XCTAssertEqual(updatedIndexes[3].0, 1)  // Event 5 to back
        XCTAssertEqual(updatedIndexes[3].1, 6)
    }

}
