//
//  MusicRecentViewController.swift
//  MeditationApp
//
//  Created by Macbook Pro on 17.06.2021.
//

import UIKit

class MusicRecentViewController: UIViewController {
    
    // Top Curved Bg Image View
    private var sectionBgImageView: RecentCurvedBgImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        customizeNavBarBackButton()
        
        setupBgImageView()
    }
    
    private func setupBgImageView() {
        sectionBgImageView = RecentCurvedBgImageView(frame: .zero)
        sectionBgImageView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(sectionBgImageView)
        
        sectionBgImageView.pinToEdges(edges: [.left, .top, .right])
        
        NSLayoutConstraint.activate([
            sectionBgImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6)
        ])
    }
    
}
