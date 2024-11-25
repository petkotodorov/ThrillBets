//
//  SportSectionItem.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/20/24.
//

import Foundation

/// Data transfer object, encapsulating the data, needed for displaying the separate sport sections
final class SportSectionItem {

    // MARK: - Variables

    /// Underlying sport
    let sport: Sport
    /// Current state of the section. Could be expanded or collapsed
    var isCollapsed: Bool = false
    /// View model, taking care of the list of events for the particular sport
    let eventSectionVM: EventSectionViewModel

    // MARK: - Initializers

    init(sport: Sport) {
        self.sport = sport
        self.eventSectionVM = EventSectionViewModel(events: sport.activeEvents)
    }
}
