//
//  UIView+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 14.06.2021.
//

import UIKit

extension UIView {
    func addBlurEffect(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
    
}
