//
//  DreamCoordinator.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

final class DreamCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = DreamViewController()
        navigationController.pushViewController(vc, animated: false)
    }
}
