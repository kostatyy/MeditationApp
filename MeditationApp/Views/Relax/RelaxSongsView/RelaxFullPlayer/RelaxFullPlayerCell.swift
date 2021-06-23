//
//  RelaxFullPlayerCell.swift
//  MeditationApp
//
//  Created by Macbook Pro on 19.06.2021.
//

import UIKit

class RelaxFullPlayerCell: UICollectionViewCell {
    
    static var reuseId = "FullTracksCellId"

    private var trackImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        trackImageView.layer.cornerRadius = trackImageView.frame.width / 2
    }
    
    private func setupViews() {
        trackImageView.image = UIImage(named: "field")
        trackImageView.contentMode = .scaleToFill
        trackImageView.layer.masksToBounds = true
        trackImageView.layer.cornerRadius = 15
        trackImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(trackImageView)
        
        trackImageView.pinToEdges()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
