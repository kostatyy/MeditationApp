//
//  AppCoordinator.swift
//  MeditationApp
//
//  Created by Macbook Pro on 15.06.2021.
//

import UIKit

final class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var window: UIWindow?
    
    init(window: UIWindow?) {
        self.window = window
    }
    
    func start() {
        let viewController = MainTabBarController()
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

