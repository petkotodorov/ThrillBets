//
//  BaseViewController.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/20/24.
//

import UIKit

/// View controller with essential functionality. To be inherited by other view controllers
class BaseViewController: UIViewController {

    // MARK: - Variables

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    // MARK: - Functionality

    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(activityIndicator)
        activityIndicator.centerXToSuperview()
        activityIndicator.centerYToSuperview()
    }

    /// Shows/hides loader depending on the parameter
    /// - Parameter start: Boolean flag, determining whether to show/hide activity indicator
    func startLoader(start: Bool) {
        DispatchQueue.main.async {
            self.view.bringSubviewToFront(self.activityIndicator)
            start ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
        }
    }

}
