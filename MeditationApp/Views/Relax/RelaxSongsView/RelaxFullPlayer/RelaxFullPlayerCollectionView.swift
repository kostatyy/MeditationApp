//
//  RelaxFullPlayerCollectionView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 19.06.2021.
//

import UIKit

class RelaxFullPlayerCollectionView: UICollectionView {
    
    // Tracks List
    private var tracksItems: [TrackInfo]
    
    init(layout: UICollectionViewLayout, tracksItems: [TrackInfo]) {
        self.tracksItems = tracksItems
        super.init(frame: .zero, collectionViewLayout: layout)
        
        configure()
    }
    
    private func configure() {
        decelerationRate = .fast
        showsHorizontalScrollIndicator = false
        backgroundColor = .clear
        dataSource = self
        delegate = self
        register(RelaxFullPlayerCell.self, forCellWithReuseIdentifier: RelaxFullPlayerCell.reuseId)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let midX  = scrollView.bounds.midX
        let midY  = scrollView.bounds.midY
        
        let point = CGPoint(x: midX, y: midY)
        guard let indexPath = self.indexPathForItem(at: point) else { return }
        
        let currentPage = indexPath.item
        let currentTrackInfo: [String: Int] = ["currentTrackIndex": currentPage]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ScrollToActiveTrack"), object: nil, userInfo: currentTrackInfo)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RelaxFullPlayerCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tracksItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: RelaxFullPlayerCell.reuseId, for: indexPath) as! RelaxFullPlayerCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width * 0.65, height: frame.width * 0.65)
    }

}
