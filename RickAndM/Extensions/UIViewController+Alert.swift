//
//  UIViewController+Alert.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 17.04.2022.
//

import UIKit

extension UIViewController {
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}
