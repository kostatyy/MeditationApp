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
            return generateNavViewController(vc: MusicViewController(), title: "Music", bgColor: .musicBgColor)
        case .Relax:
            return generateNavViewController(vc: RelaxViewController(), title: "Music", bgColor: .relaxBgColor)
        case .Dream:
            return generateNavViewController(vc: DreamViewController(), title: "Music", bgColor: .dreamBgColor)
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
    
    fileprivate func generateNavViewController(vc: UIViewController, title: String, bgColor: UIColor) -> UINavigationController {
        vc.view.backgroundColor = .white
        vc.setupNavigationButtons()
        let navController = UINavigationController(rootViewController: vc)
        navController.customizeNavigationBar()
        return navController
    }
}
