//
//  Coordinator.swift
//  MeditationApp
//
//  Created by Macbook Pro on 15.06.2021.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get }
    func start()
//    func finishChild(coordinator: Coordinator)
}

