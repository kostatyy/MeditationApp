//
//  UIViewController+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

extension UIViewController {
    
    /* View Controller Customization */
    func customizeViewController(title: String, image: UIImage, bgColor: UIColor) {
        let tabBarItem = UITabBarItem()
        
        tabBarItem.title = title
        tabBarItem.image = image
        view.backgroundColor = bgColor
        
        self.tabBarItem = tabBarItem
    }
    
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
