//
//  UIViewController+Extension.swift
//  SISimulation
//
//  Created by Róbert Oravec on 10/01/2020.
//  Copyright © 2020 Robo. All rights reserved.
//

import UIKit

extension UIViewController {
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert)
        let okAction = UIAlertAction(
            title: "Ok",
            style: .cancel,
            handler: nil)
        alert.addAction(okAction)
        present(
            alert,
            animated: true,
            completion: nil)
    }

    func makeLoadingOverlay() {
        let alert = UIAlertController(
            title: nil, message: "Please wait...",
            preferredStyle: .alert
        )
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .medium
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }

    func dismissLoadingOverlay() {
        dismiss(animated: false, completion: nil)
    }
}
