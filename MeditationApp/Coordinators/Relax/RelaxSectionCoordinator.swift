//
//  RelaxSectionCoordinator.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

final class RelaxSectionCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let vc = RelaxSectionViewController()
        let viewModel = RelaxSectionViewModel()
        viewModel.configure()
        vc.viewModel = viewModel
        navigationController.customizeNavigationBar()
        navigationController.fadeNavigationAnimation(.Push)
        navigationController.pushViewController(vc, animated: false)
    }
}
