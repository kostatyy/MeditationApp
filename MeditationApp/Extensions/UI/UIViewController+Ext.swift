//
//  UIViewController+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

extension UIViewController {
    /* Setting Up Navigation Buttons (Settings, Notifications) */
    func setupNavigationButtons() {
        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let bellImage = UIImage(named: "bell")?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: bellImage, style: .done, target: self, action: nil)
    }
}

extension UINavigationController {
    /* Navigation Bar Customization */
    func customizeNavigationBar() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.mainColor
        ]
    }
}
