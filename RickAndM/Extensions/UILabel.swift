//
//  Extensions.swift
//  RickAndM
//
//  Created by Andrey Khakimov on 15.04.2022.
//

import UIKit

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        guard let text = self.text else { return }
        let attributeString = NSMutableAttributedString(string: text)
        let style = NSMutableParagraphStyle()
        
        style.lineSpacing = lineHeight
        attributeString.addAttribute(
            NSAttributedString.Key.paragraphStyle,
            value: style,
            range: NSMakeRange(0, attributeString.length))
        
        self.attributedText = attributeString
    }
}
