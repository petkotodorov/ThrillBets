//
//  Sport.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/18/24.
//

import Foundation

/// Type, describing sports, which are coming from the BE
struct Sport: Codable, Equatable {

    // MARK: - Variables

    var id: String
    var name: String
    var activeEvents: [Event]

    enum CodingKeys: String, CodingKey {
        case id = "i"
        case name = "d"
        case activeEvents = "e"
    }
}
