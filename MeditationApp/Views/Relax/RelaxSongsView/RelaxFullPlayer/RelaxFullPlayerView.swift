//
//  RelaxFullPlayerView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 19.06.2021.
//

import UIKit

class RelaxFullPlayerView: UIView {
    
    // Views
    private var closeButton = UIButton()
    private var tracksCollectionView: RelaxFullPlayerCollectionView!
    private var currentTrackTitle = UILabel()
    private var currentTrackArtist = UILabel()
    private var vStack = UIStackView()
    
    // Tracks
    private var tracksList: [TrackInfo]
    private var activeTrack: Int
    
    init(frame: CGRect, tracksList: [TrackInfo], activeTrack: Int) {
        self.tracksList = tracksList
        self.activeTrack = activeTrack
        
        super.init(frame: frame)
        
        configure()
        setupViews()
        setupCollectionView()
        setupLayouts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleScrollToActiveTrack(notification:)), name: NSNotification.Name(rawValue: "ScrollToActiveTrack"), object: nil)
    }
    
    /* Setup View Configuration */
    private func configure() {
        
        layer.cornerRadius = 20
        backgroundColor = .white
    }
    
    private func setupViews() {
        currentTrackTitle.text = tracksList[activeTrack].trackName
        currentTrackTitle.font = UIFont.setFont(size: .Largest, weight: .Bold)
        currentTrackTitle.textColor = .mainColor
        currentTrackTitle.textAlignment = .center
        
        currentTrackArtist.text = tracksList[activeTrack].trackArtist
        currentTrackArtist.font = UIFont.setFont(size: .Medium)
        currentTrackArtist.textColor = .lightGray
        currentTrackArtist.textAlignment = .center
        
        vStack.axis = .vertical
        vStack.alignment = .center
        vStack.spacing = 5
        
        closeButton.setBackgroundImage(UIImage(systemName: "xmark.circle")?.withRenderingMode(.alwaysOriginal).withTintColor(.lightGray), for: .normal)
        closeButton.addTarget(self, action: #selector(closeFullPlayer), for: .touchUpInside)
        
        [currentTrackTitle, currentTrackArtist, vStack, closeButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupCollectionView() {
        let layout = RelaxFullPlayerLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 30
        tracksCollectionView = RelaxFullPlayerCollectionView(layout: layout, tracksItems: tracksList)
        tracksCollectionView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupLayouts() {
        addSubview(tracksCollectionView)
        addSubview(vStack)
        addSubview(closeButton)
        vStack.addArrangedSubview(currentTrackTitle)
        vStack.addArrangedSubview(currentTrackArtist)
        
        NSLayoutConstraint.activate([
            closeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            closeButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor),
            closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            
            tracksCollectionView.topAnchor.constraint(equalTo: closeButton.bottomAnchor, constant: 5),
            tracksCollectionView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tracksCollectionView.widthAnchor.constraint(equalTo: widthAnchor),
            tracksCollectionView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            
            vStack.topAnchor.constraint(equalTo: tracksCollectionView.bottomAnchor, constant: 5),
            vStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            vStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }
    
    
    //MARK: - Handling Scrolling To New Active Track To Change Title And Artist Labels
    @objc private func handleScrollToActiveTrack(notification: NSNotification) {
        guard let currentTrackIndex = notification.userInfo!["currentTrackIndex"] as? Int else { return }
        
        [currentTrackTitle, currentTrackArtist].forEach {
            $0.fadeTransition(0.4)
        }
        currentTrackTitle.text = self.tracksList[currentTrackIndex].trackName
        currentTrackArtist.text = self.tracksList[currentTrackIndex].trackArtist
    }
    
    @objc private func closeFullPlayer() {
        NotificationCenter.default.post(name: NSNotification.Name("ClosingFullPlayer"), object: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
