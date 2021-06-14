//
//  MainTabBarController.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    var customTabBar: TabNavigationMenu!
    
    var tabBarWidth: CGFloat!
    var tabBarHeight: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarWidth = view.frame.width
        tabBarHeight = view.frame.height * 0.15
        
        tabBar.isHidden = true
        loadTabBar()
    }
    
    func loadTabBar() {
        let tabItems: [TabItem] = [.Music, .Relax, .Dream]
        
        setupCustomTabMenu(tabItems) { (controllers) in
            self.viewControllers = controllers
        }
        
        selectedIndex = 0
    }
    
    func setupCustomTabMenu(_ menuItems: [TabItem], completion: @escaping ([UIViewController]) -> Void) {
        
        let frame = tabBar.frame
        var controllers = [UIViewController]()
        
        self.customTabBar = TabNavigationMenu(menuItems: menuItems, frame: frame)
        self.customTabBar.translatesAutoresizingMaskIntoConstraints = false
        self.customTabBar.clipsToBounds = true
        self.customTabBar.itemTapped = self.changeTab
        
        // Add it to the view
        self.view.addSubview(customTabBar)
        
        // Add positioning constraints to place the nav menu right where the tab bar should be
        NSLayoutConstraint.activate([
            self.customTabBar.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
            self.customTabBar.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor),
            self.customTabBar.heightAnchor.constraint(equalToConstant: tabBarHeight),
            self.customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor)
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
