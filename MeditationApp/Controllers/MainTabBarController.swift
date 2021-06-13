//
//  MainTabBarController.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    //MARK: - View Controllers
    private let musicVC = UINavigationController(rootViewController: MusicViewController())
    private let relaxVC = UINavigationController(rootViewController: RelaxViewController())
    private let dreamVC = UINavigationController(rootViewController: DreamViewController())

    //MARK: - View Controllers Preferences
    private let vcTitles = ["Music", "Relax", "Dream"]
    private let vcBgColors: [UIColor] = [.musicBgColor, .relaxBgColor, .dreamBgColor]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewControllersList = [musicVC, relaxVC, dreamVC]
        for (index, item) in viewControllersList.enumerated() {
            item.customizeViewController(title: vcTitles[index], image: UIImage(systemName: "paperplane")!, bgColor: vcBgColors[index])
        }
        
        tabBar.unselectedItemTintColor = .black
        
        viewControllers = [
            musicVC, relaxVC, dreamVC
        ]

    }

}
