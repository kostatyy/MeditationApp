//
//  UIViewController+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

enum NavigationDirection {
    case Push, Pop
}

extension UIViewController {
    /* Setting Up Navigation Buttons (Settings, Notifications) */
    func setupNavigationButtons() {
        let menuImage = UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal)
        let bellImage = UIImage(named: "bell")?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: menuImage, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: bellImage, style: .done, target: self, action: nil)
    }
    
    /* Navigation Bar Back Button Customization */
    func customizeNavBarBackButton() {
        navigationItem.hidesBackButton = true
        let backButton = UIImage(systemName: "arrow.left")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        let backBarButtonItem = UIBarButtonItem(image: backButton, style: .done, target: self, action: #selector(handleBackButton))
        self.navigationItem.setLeftBarButton(backBarButtonItem, animated: true)
    }
    
    @objc func handleBackButton() {
        navigationController?.fadeNavigationAnimation(.Pop)
        navigationController?.popViewController(animated: false)
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
    
    func fadeNavigationAnimation(_ direction: NavigationDirection) {
        UIView.animate(withDuration: 0.5) {
            customTabBar.transform = CGAffineTransform(translationX: 0,
                                                       y: direction == .Push ? customTabBar.frame.height : 0)
        }
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: .easeIn)
        transition.type = .fade
        self.view.layer.add(transition, forKey: nil)
    }
}
