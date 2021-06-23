//
//  MusicRecentCell.swift
//  MeditationApp
//
//  Created by Macbook Pro on 17.06.2021.
//

import UIKit

class MusicRecentCell: UICollectionViewCell {
    
    static let reuseId = "RecendUploadedCellId"

    // Views
    var musicBgImageView = UIImageView()
    var musicTitle = UILabel()
    private var vStack = UIStackView()
    private var lineView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        setupViews()
        setupLayouts()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupShadow(cornerRad: 30, shadowRad: 10, shadowOp: 0.8, offset: CGSize(width: 0, height: 0))
    }
    
    private func setupViews() {
        musicBgImageView.image = UIImage(named: "desert")
        musicBgImageView.contentMode = .scaleToFill
        musicBgImageView.layer.cornerRadius = 30
//        musicBgImageView.layer.masksToBounds = true
        musicBgImageView.setGradientFill(colorTop: UIColor.red.cgColor, colorBottom: UIColor.blue.cgColor, cornerRadius: 30, startPoint: CGPoint(x: 1, y: 0), endPoint: CGPoint(x: 0, y: 1), opacity: 1)

        musicTitle.text = "Best of 2018"
        musicTitle.font = UIFont.setFont(size: .Medium, weight: .Bold)
        musicTitle.textColor = .white
        
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 5
        lineView.backgroundColor = .green
        
        [musicBgImageView, musicTitle, lineView, vStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayouts() {
        addSubview(musicBgImageView)
        musicBgImageView.addSubview(vStack)
        vStack.addArrangedSubview(musicTitle)
        vStack.addArrangedSubview(lineView)
        
        musicBgImageView.pinToEdges()
        
        NSLayoutConstraint.activate([
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.centerYAnchor.constraint(equalTo: centerYAnchor),
            vStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            lineView.heightAnchor.constraint(equalToConstant: 2),
            lineView.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 0.2)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
