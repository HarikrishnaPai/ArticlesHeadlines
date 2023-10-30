//
//  UIViewController+Alert.swift
//  ArticlesHeadlines
//
//  Created by Hari on 29/10/2023.
//

import UIKit

extension UIViewController {
    
    // MARK: - Public Methods
    public func showAlert(title: String?, message: String?) {
        let okAction = UIAlertAction(title: String(localized: "alert.button.ok"), style: .cancel, handler: nil)
        self.showAlert(title: title, message: message,
                       actions: [ okAction ], preferredAction: okAction)
    }
    
    public func showAlert(title: String?, message: String?, actions: [UIAlertAction]?,
                          preferredAction: UIAlertAction) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action: UIAlertAction in actions ?? [] {
            alertController.addAction(action)
        }
        alertController.preferredAction = preferredAction
        self.present(alertController, animated: true, completion: nil)
    }
}
