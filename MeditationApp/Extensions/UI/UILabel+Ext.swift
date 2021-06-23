//
//  UILabel+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

extension UILabel {
    func addKern(_ kernValue: CGFloat) {
        guard let attributedText = attributedText,
            attributedText.string.count > 0,
            let fullRange = attributedText.string.range(of: attributedText.string) else {
                return
        }
        let updatedText = NSMutableAttributedString(attributedString: attributedText)
        updatedText.addAttributes([
            .kern: kernValue
            ], range: NSRange(fullRange, in: attributedText.string))
        self.attributedText = updatedText
    }

}
