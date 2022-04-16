//
//  Extensions.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 15.04.2022.
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

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
//        guard let text = self.text else { return }
        
        let attributeString = NSMutableAttributedString(string: self.text ?? "")
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = lineHeight
        attributeString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }
}
