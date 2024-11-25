//
//  ReusableView.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/20/24.
//

import Foundation

protocol ReusableView {

    /// Identifier matching the name of the class
    static var reuseIdentifier: String { get }

}

extension ReusableView {

    /// Identifier matching the name of the class
    static var reuseIdentifier: String {
        return String(describing: self)
    }

}
