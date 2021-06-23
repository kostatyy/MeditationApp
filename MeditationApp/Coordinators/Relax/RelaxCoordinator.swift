//
//  RelaxCoordinator.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

final class RelaxCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = RelaxViewController()
        let viewModel = RelaxViewModel()
        viewModel.coordinator = self
        vc.viewModel = viewModel
        vc.view.backgroundColor = .white
        vc.setupNavigationButtons()
        navigationController.customizeNavigationBar()
        navigationController.pushViewController(vc, animated: false)
    }
    
    func goToSelectedSection() {
        let relaxSectionCoordinator = RelaxSectionCoordinator(navigationController: navigationController)
        childCoordinators.append(relaxSectionCoordinator)
        relaxSectionCoordinator.start()
    }
}
