//
//  MusicViewController.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

class MusicViewController: UICollectionViewController {
    
    var viewModel: MusicViewModel!
    
    static let categoryHeaderId = "CategoryHeaderId"
    
    init() {
        let layout = MusicViewController.setupLayout()
        super.init(collectionViewLayout: layout)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(MusicArtistsCell.self, forCellWithReuseIdentifier: MusicArtistsCell.reuseId)
        collectionView.register(MusicRecentCell.self, forCellWithReuseIdentifier: MusicRecentCell.reuseId)
        collectionView.register(MusicNewSinglesCell.self, forCellWithReuseIdentifier: MusicNewSinglesCell.reuseId)
        collectionView.register(MusicSectionHeader.self, forSupplementaryViewOfKind: MusicViewController.categoryHeaderId, withReuseIdentifier: MusicSectionHeader.headerId)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.contentInset.top = 20
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell
        if indexPath.section == 0 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicArtistsCell.reuseId, for: indexPath) as! MusicArtistsCell
        } else if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicRecentCell.reuseId, for: indexPath) as! MusicRecentCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: MusicNewSinglesCell.reuseId, for: indexPath) as! MusicNewSinglesCell
        }
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.recentMusicSelected()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MusicSectionHeader.headerId, for: indexPath) as! MusicSectionHeader
        if indexPath.section == 1 {
            header.headerTitle.text = "Recentrly Uploaded"
        } else {
            header.headerTitle.text = "New Singles"
        }
        return header
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setting Up Custom Compositional Layout
extension MusicViewController {
    private static func setupLayout() -> UICollectionViewLayout {
        let insideInsetVar: CGFloat = 15
        let edgeInsetVar: CGFloat = 35
        
        let layout = UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            
            if sectionNumber == 0 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: insideInsetVar)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.22), heightDimension: .fractionalWidth(0.25))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: insideInsetVar, bottom: edgeInsetVar, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                return section
                
            } else if sectionNumber == 1 {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: insideInsetVar)

                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: insideInsetVar)
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: insideInsetVar, leading: insideInsetVar, bottom: edgeInsetVar, trailing: insideInsetVar)
                section.orthogonalScrollingBehavior = .groupPaging
                section.boundarySupplementaryItems = [.init(
                                                        layoutSize: .init(widthDimension: .fractionalHeight(1), heightDimension: .absolute(50)),
                                                        elementKind: categoryHeaderId,
                                                        alignment: .topLeading)]
                return section
            } else {
                let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
                let item = NSCollectionLayoutItem(layoutSize: itemSize)
                item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: insideInsetVar)
                
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.27), heightDimension: .fractionalWidth(0.3))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
                
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets = NSDirectionalEdgeInsets(top: insideInsetVar, leading: insideInsetVar, bottom: insideInsetVar, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [.init(
                                                        layoutSize: .init(widthDimension: .fractionalHeight(1), heightDimension: .absolute(50)),
                                                        elementKind: categoryHeaderId,
                                                        alignment: .topLeading)]
                return section
            }
        }
        return layout
    }
}
