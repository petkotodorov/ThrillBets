//
//  SportImage.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/19/24.
//

import UIKit

/// Supported sports
enum SportImage: String {
    case soccer = "SOCCER"
    case basketball = "BASKETBALL"
    case tennis = "TENNIS"
    case tableTennis = "TABLE TENNIS"
    case volleyball = "VOLLEYBALL"
    case esports = "ESPORTS"
    case beachVolleyball = "BEACH VOLLEYBALL"
    case badminton = "BADMINTON"
    
    /// Icon, representing the particular sport
    var icon: String {
        switch self {
        case .soccer:
            return "⚽️"
        case .basketball:
            return "🏀"
        case .tennis:
            return "🎾"
        case .tableTennis:
            return "🏓"
        case .volleyball:
            return "🏐"
        case .esports:
            return "🎮"
        case .beachVolleyball:
            return "🏖️🏐"
        case .badminton:
            return "🏸"
        }
    }
}

