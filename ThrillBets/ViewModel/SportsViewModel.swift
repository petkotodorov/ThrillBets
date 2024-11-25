//
//  SportsViewModel.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/18/24.
//

import Foundation

/// View model, responsible for loading and preparing the data for the list of sports
final class SportsViewModel {

    // MARK: - Variables

    private let sportsService: SportsServiceProtocol
    private var sportSections = [SportSectionItem]()

    // MARK: - Initializers
    
    /// Designated initializer of the view model
    /// - Parameter sportsService: service, used for retrieving the data from BE
    init(sportsService: SportsServiceProtocol = SportsService()) {
        self.sportsService = sportsService
    }

    // MARK: - Functionality
    
    /// Initiate loading of the sport events
    func load() async throws {
        do {
            let sports = try await sportsService.getSports()
            self.sportSections = sports.map { SportSectionItem(sport: $0) }
        } catch {
            throw error
        }
    }
    
    /// Total number of sections (types of sports)
    /// - Returns: the number of sections
    func numberOfSections() -> Int {
        return sportSections.count
    }
    
    /// Particular sport for the chosen index
    /// - Parameter index: index of the current section
    /// - Returns: the sport DTO, representing the current section
    func sportSection(at index: Int) -> SportSectionItem {
        return sportSections[index]
    }
}
