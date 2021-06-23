//
//  MusicNewSinglesCell.swift
//  MeditationApp
//
//  Created by Macbook Pro on 17.06.2021.
//

import UIKit

class MusicNewSinglesCell: UICollectionViewCell {
    
    static let reuseId = "NewSinglesCellId"

    // Views
    var musicBgImageView = UIImageView()
    var musicTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        setupLayouts()
    }
    
    private func setupViews() {
        musicBgImageView.image = UIImage(named: "desert")
        musicBgImageView.contentMode = .scaleToFill
        musicBgImageView.layer.cornerRadius = 30
        musicBgImageView.layer.masksToBounds = true

        musicTitle.text = "Bad Guy - Billie Elish"
        musicTitle.font = UIFont.setFont(size: .Small)
        musicTitle.textColor = .black
        
        [musicBgImageView, musicTitle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayouts() {
        addSubview(musicBgImageView)
        addSubview(musicTitle)
        
        musicBgImageView.pinToEdges(edges: [.left, .top, .right])
        
        NSLayoutConstraint.activate([
            musicBgImageView.heightAnchor.constraint(equalTo: musicBgImageView.widthAnchor),
            
            musicTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            musicTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            musicTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
