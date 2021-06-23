//
//  MainTabBarController.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

var customTabBar: TabNavigationMenu!

class MainTabBarController: UITabBarController {
    
    var tabBarWidth: CGFloat!
    var tabBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarWidth = view.frame.width
        tabBarHeight = view.frame.height * 0.15
        
        tabBar.isHidden = true
        loadTabBar()
//        customTabBar.isHidden = true
    }
    
    func loadTabBar() {
        let tabItems: [TabItem] = [.Music, .Relax, .Dream]
        
        setupCustomTabMenu(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        
        selectedIndex = 1
    }
    
    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        
        customTabBar = TabNavigationMenu(menuItems: menuItems, frame: frame)
        customTabBar.translatesAutoresizingMaskIntoConstraints = false
        customTabBar.clipsToBounds = true
        customTabBar.itemTapped = self.changeTab
        
        // Add it to the view
        self.view.addSubview(customTabBar)
        
        // Add positioning constraints to place the nav menu right where the tab bar should be
        NSLayoutConstraint.activate([
            customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
        ])
        
        for i in 0 ..< menuItems.count {
            controllers.append(menuItems[i].viewController)
        }
        
        self.view.layoutIfNeeded()
        completion(controllers) // setup complete. handoff here
    }
    
    func changeTab(tab: Int) {
        selectedIndex = tab
    }
}
