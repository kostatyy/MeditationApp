//
//  MusicRecentCoordinator.swift
//  MeditationApp
//
//  Created by Macbook Pro on 17.06.2021.
//

import UIKit

final class MusicRecentCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MusicRecentViewController()
        navigationController.customizeNavigationBar()
        navigationController.fadeNavigationAnimation(.Push)
        navigationController.pushViewController(vc, animated: false)
    }
}
