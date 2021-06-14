//
//  UIViewController+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

extension UIViewController {
    
    /* Navigation Bar Customization */
    func customizeNaviogationBar() {
        navigationController?.navigationBar.backItem?.title = ""
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style:.plain, target:nil, action:nil)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: UIColor.white
        ]
    }
    
}
