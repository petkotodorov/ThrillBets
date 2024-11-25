//
//  Array+Extension.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/19/24.
//

import Foundation

extension Array where Element: Equatable {
    /// Moves a particular to a chosen index in the same array
    /// - Parameters:
    ///   - item: element to be moved
    ///   - newIndex: new index of the element in the array
    mutating func move(_ item: Element, to newIndex: Index) {
        if let index = firstIndex(of: item) {
            move(at: index, to: newIndex)
        }
    }
    
    /// Moves a particular element in the beginning of the array
    /// - Parameter item: element to be moved
    mutating func bringToFront(item: Element) {
        move(item, to: 0)
    }
    
    /// Moves a particular item in the end of the array
    /// - Parameter item: element to be moved
    mutating func sendToBack(item: Element) {
        move(item, to: endIndex-1)
    }
}

extension Array {
    mutating func move(at index: Index, to newIndex: Index) {
        insert(remove(at: index), at: newIndex)
    }
}
