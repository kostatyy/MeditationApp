//
//  TabItem.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

enum TabItem: String, CaseIterable {
    
    case Music = "Music"
    case Relax = "Relax"
    case Dream = "Dream"
    
    var viewController: UIViewController {
        switch self {
        case .Music:
            let musicCoordinator = MusicCoordinator(navigationController: UINavigationController())
            musicCoordinator.start()
            return musicCoordinator.navigationController
        case .Relax:
            let musicCoordinator = RelaxCoordinator(navigationController: UINavigationController())
            musicCoordinator.start()
            return musicCoordinator.navigationController
        case .Dream:
            let musicCoordinator = DreamCoordinator(navigationController: UINavigationController())
            musicCoordinator.start()
            return musicCoordinator.navigationController
        }
    }
    
    // Item icon
    var icon: UIImage {
        switch self {
        case .Music:
            return UIImage(named: "musicIcon")!
        case .Relax:
            return UIImage(named: "relaxIcon")!
        case .Dream:
            return UIImage(named: "dreamIcon")!
        }
    }
    
    var displayTitle: String {
        return self.rawValue.capitalized(with: nil)
    }
    
    fileprivate func generateNavViewController(vc: UIViewController, bgColor: UIColor) -> UINavigationController {
        vc.view.backgroundColor = .white
        vc.setupNavigationButtons()
        let navController = UINavigationController(rootViewController: vc)
        navController.customizeNavigationBar()
        return navController
    }
}
