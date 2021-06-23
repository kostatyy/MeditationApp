//
//  MusicSectionHeader.swift
//  MeditationApp
//
//  Created by Macbook Pro on 17.06.2021.
//

import UIKit

class MusicSectionHeader: UICollectionReusableView {
    
    static let headerId = "HeaderId"
    
    // Views
    var headerTitle = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    private func configure() {
        headerTitle.textColor = .black
        headerTitle.font = UIFont.setFont(size: .ExtraLarge, weight: .Bold)
        
        headerTitle.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(headerTitle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        NSLayoutConstraint.activate([
            headerTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerTitle.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            headerTitle.leftAnchor.constraint(equalTo: leftAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
