//
//  RelaxSongsCell.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

class RelaxSongsCell: UICollectionViewCell {
    
    static var reuseId = "RelaxSongCellId"
    
    // Views
    var songPlayIcon = UIImageView()
    var songName = UILabel()
    var songDuration = UILabel()
    
    // Vars
    private var sideInset: CGFloat!
    private var animationDuration: TimeInterval!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        sideInset = frame.width * 0.05
        setupViews()
        setupLayouts()
    }
    
    func update(relaxSongsCellViewModel: RelaxSongsCellViewModel) {
        songName.text = relaxSongsCellViewModel.trackTitle()
        songDuration.text = relaxSongsCellViewModel.trackDuration()
    }
    
    override var isSelected: Bool {
        didSet {
            animationDuration = isSelected ? 0.5 : 0.25
            UIView.animate(withDuration: animationDuration) {
                self.songPlayIcon.alpha = self.isSelected ? 1 : 0
                [self.songName].forEach {
                    $0.font = self.isSelected ? .setFont(size: .Large, weight: .Bold) : .setFont(size: .Large, weight: .Regular)
                    $0.alpha = self.isSelected ? 1 : 0.5
                }
            }
            
        }
    }
    
    private func setupViews() {
        songPlayIcon.image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        songPlayIcon.contentMode = .scaleAspectFit
        songPlayIcon.alpha = 0
        
        songName.font = UIFont.setFont(size: .Large)
        songName.addKern(1.7)
        songName.textColor = .white
        songName.alpha = 0.5
        
        songDuration.font = UIFont.setFont(size: .Large)
        songDuration.addKern(1.7)
        songDuration.textAlignment = .right
        songDuration.textColor = .white
        songDuration.alpha = 0.5
        
        [songPlayIcon, songName, songDuration].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayouts() {
        addSubview(songPlayIcon)
        addSubview(songName)
        addSubview(songDuration)
        
        NSLayoutConstraint.activate([
            songPlayIcon.leftAnchor.constraint(equalTo: leftAnchor, constant: sideInset),
            songPlayIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            songPlayIcon.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.05),
            songPlayIcon.heightAnchor.constraint(equalTo: songPlayIcon.widthAnchor),
            
            songDuration.rightAnchor.constraint(equalTo: rightAnchor, constant: -sideInset),
            songDuration.centerYAnchor.constraint(equalTo: centerYAnchor),

            songName.leftAnchor.constraint(equalTo: songPlayIcon.rightAnchor, constant: sideInset),
            songName.rightAnchor.constraint(equalTo: songDuration.leftAnchor, constant: -sideInset),
            songName.centerYAnchor.constraint(equalTo: centerYAnchor),
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
