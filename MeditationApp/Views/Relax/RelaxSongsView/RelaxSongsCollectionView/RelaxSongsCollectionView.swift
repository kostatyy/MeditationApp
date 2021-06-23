//
//  RelaxSongsCollectionView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

class RelaxSongsCollectionView: UICollectionView {
    
    private var tracksList: [TrackInfo]
    
    init(tracksList: [TrackInfo]) {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 20
        self.tracksList = tracksList

        super.init(frame: .zero, collectionViewLayout: layout)
    
        configure()
    }
    
    private func configure() {
        showsVerticalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        register(RelaxSongsCell.self, forCellWithReuseIdentifier: RelaxSongsCell.reuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RelaxSongsCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracksList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelaxSongsCell.reuseId, for: indexPath) as! RelaxSongsCell
        cell.update(relaxSongsCellViewModel: RelaxSongsCellViewModel(track: tracksList[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let trackInfo: [String: RelaxSongsCellViewModel] = ["track": RelaxSongsCellViewModel(track: tracksList[indexPath.row])]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "SelectingPlayingTrack"), object: nil, userInfo: trackInfo)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: frame.height / 10)
    }
}
