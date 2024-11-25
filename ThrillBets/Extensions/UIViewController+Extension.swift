//
//  UIViewController+Extension.swift
//  Kaizen
//
//  Created by Petko Todorov on 6/18/24.
//

import UIKit

extension UIViewController {
    
    /// Display an alert dialog from a view controller
    /// - Parameters:
    ///   - title: optional title of the alert
    ///   - message: message of the alert
    ///   - okAction: optional event to execute, after tapping "OK"
    func display(alert title: String? = nil,
                 message: String,
                 okAction: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title ?? "",
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok",
                                                style: .default,
                                                handler: okAction))
        DispatchQueue.main.async {
            self.present(alertController,
                         animated: true,
                         completion: nil)
        }

    }
}
