//
//  EventSectionItem.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/20/24.
//

import Foundation

/// Data transfer object, encapsulating the data, needed for displaying the separate event items
final class EventSectionItem {

    // MARK: - Variables

    /// Underlying event
    let event: Event
    /// Current state of the item. Could be added to favorites or not
    var isFavorite: Bool = false

    // MARK: - Initializers

    init(event: Event) {
        self.event = event
    }

}

// MARK: - Extensions

extension EventSectionItem: Equatable {

    static func == (lhs: EventSectionItem, rhs: EventSectionItem) -> Bool {
        lhs.event == rhs.event && lhs.isFavorite == rhs.isFavorite
    }

}
