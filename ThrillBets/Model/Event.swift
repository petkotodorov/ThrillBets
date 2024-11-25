//
//  Event.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/18/24.
//

import Foundation

/// Type, describing events, which are coming from the BE
struct Event: Codable, Equatable {

    // MARK: - Variables

    var sportId: String
    var eventId: String
    var name: String
    var startTime: Int

    enum CodingKeys: String, CodingKey {
        case sportId = "si"
        case eventId = "i"
        case name = "d"
        case startTime = "tt"
    }
}
