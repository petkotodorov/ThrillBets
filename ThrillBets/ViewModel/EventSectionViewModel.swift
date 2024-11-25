//
//  EventSectionViewModel.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/20/24.
//

import Foundation

/// View model, responsible for the presentation of the list of events for a particular sport
final class EventSectionViewModel {

    // MARK: - Variables
    private var eventSectionItems: [EventSectionItem]
    
    /// Closure, executed when a particular event is added to favorites. The closure passes the indexes of the collection, which need to be reloaded
    var updateIndexes: ((Int, Int) -> Void)?

    // MARK: - Initializers
    
    /// Designated initialized
    /// - Parameter events: list of the events
    init(events: [Event]) {
        self.eventSectionItems = events.map { EventSectionItem(event: $0) }
    }

    // MARK: - Functionality
    
    /// Total number of items (events)
    /// - Returns: the number of events
    func numberOfItems() -> Int {
        return eventSectionItems.count
    }
    
    /// Particular event for the chosen index
    /// - Parameter index: index of the current event
    /// - Returns: the event DTO, representing the current item
    func item(at index: Int) -> EventSectionItem {
        return eventSectionItems[index]
    }
    
    /// Add or remote a particular event from favorites
    /// - Parameter index: the index of the particular event in the list
    func markFavorite(at index: Int) {
        guard index < eventSectionItems.count else { return }
        eventSectionItems[index].isFavorite.toggle()
        if eventSectionItems[index].isFavorite {
            eventSectionItems.bringToFront(item: eventSectionItems[index])
            updateIndexes?(index, 0)
        } else {
            eventSectionItems.sendToBack(item: eventSectionItems[index])
            updateIndexes?(index, eventSectionItems.count - 1)
        }
    }
}
