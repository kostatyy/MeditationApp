//
//  MusicArtistsCell.swift
//  MeditationApp
//
//  Created by Macbook Pro on 18.06.2021.
//

import UIKit

class MusicArtistsCell: UICollectionViewCell {
    
    static let reuseId = "ArtistsCellId"

    // Views
    var artistImageView = UIImageView()
    var artistTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        setupLayouts()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        artistImageView.layer.cornerRadius = artistImageView.frame.width / 2
    }
    
    private func setupViews() {
        artistImageView.image = UIImage(named: "desert")
        artistImageView.contentMode = .scaleToFill
        artistImageView.layer.masksToBounds = true

        artistTitle.text = "Drake"
        artistTitle.textAlignment = .center
        artistTitle.font = UIFont.setFont(size: .Small, weight: .Bold)
        artistTitle.textColor = .black
        
        [artistImageView, artistTitle].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayouts() {
        addSubview(artistImageView)
        addSubview(artistTitle)
        
        artistImageView.pinToEdges(edges: [.left, .top, .right])
        
        NSLayoutConstraint.activate([
            artistImageView.heightAnchor.constraint(equalTo: artistImageView.widthAnchor),
            
            artistTitle.bottomAnchor.constraint(equalTo: bottomAnchor),
            artistTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9),
            artistTitle.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
