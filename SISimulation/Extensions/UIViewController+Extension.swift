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
}
