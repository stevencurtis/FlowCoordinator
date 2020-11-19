//
//  UIViewController+showNotification.swift
//  FlowCoordinator
//
//  Created by Steven Curtis on 18/11/2020.
//

import UIKit

extension UIViewController {
    func showNotification(title: String, message: String, completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction: UIAlertAction = UIAlertAction.init(title: "OK", style: .default) { (_) in
            guard let completion = completion else {return}
            completion()
        }

        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
