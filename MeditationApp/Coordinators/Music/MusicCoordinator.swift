//
//  MusicCoordinator.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

final class MusicCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = MusicViewController()
        let viewModel = MusicViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        vc.view.backgroundColor = .white
        vc.setupNavigationButtons()
        navigationController.customizeNavigationBar()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToRecentlySection() {
        let recentSectionCoordinator = MusicRecentCoordinator(navigationController: navigationController)
        childCoordinators.append(recentSectionCoordinator)
        recentSectionCoordinator.start()
    }
}
