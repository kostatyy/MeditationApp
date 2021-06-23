//
//  RelaxSongsView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

class RelaxSongsView: UIView {
    
    // Songs List
    private var tracksListCollectionView: RelaxSongsCollectionView!
    private var tracksList: [TrackInfo] = []
    
    // Player View
    private var playerView = RelaxPlayerView()
    private var playerViewTopConstraint: NSLayoutConstraint!
    
    init(frame: CGRect, tracksList: [TrackInfo]) {
        self.tracksList = tracksList
        super.init(frame: frame)
        
        configure()
        setupSongsCollectionView()
        
        tracksListCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .centeredVertically)
        
        let trackInfo: [String: RelaxSongsCellViewModel] = ["track": RelaxSongsCellViewModel(track: tracksList[0])]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectingPlayingTrack"), object: nil, userInfo: trackInfo)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupPlayerView()
        tracksListCollectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: playerView.frame.height, right: 0)
        animateSongsCollectionView()
    }
    
    /* Setup View Configuration */
    private func configure() {
        addBlurEffect(style: .systemChromeMaterialDark)
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
    
    /* Setting Up Songs Collection View */
    private func setupSongsCollectionView() {
        tracksListCollectionView = RelaxSongsCollectionView(tracksList: tracksList)
        tracksListCollectionView.alpha = 0
        
        tracksListCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(tracksListCollectionView)

        NSLayoutConstraint.activate([
            tracksListCollectionView.rightAnchor.constraint(equalTo: rightAnchor),
            tracksListCollectionView.leftAnchor.constraint(equalTo: leftAnchor),
            tracksListCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tracksListCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7)
        ])
    }

    private func animateSongsCollectionView() {
        UIView.animate(withDuration: 0.5, delay: 0.5) {
            self.tracksListCollectionView.alpha = 1
        }
    }
    
    /* Setting Up Player View */
    private func setupPlayerView() {
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        superview?.addSubview(playerView)
        
        playerView.pinToEdges(edges: [.bottom, .left, .right])
        
        playerViewTopConstraint = playerView.topAnchor.constraint(equalTo: bottomAnchor, constant: -frame.height * 0.15)
        playerViewTopConstraint?.isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

