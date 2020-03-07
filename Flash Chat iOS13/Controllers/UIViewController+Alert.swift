//
//  UIViewController+Alert.swift
//  Flash Chat iOS13
//
//  Created by Oleksandr Hozhulovskyi on 18.02.2020.
//  Copyright © 2020 Angela Yu. All rights reserved.
//

import UIKit

extension UIViewController {
    func show(_ error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

