//
//  RelaxViewController.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

class RelaxViewController: UIViewController {
    
    // Curve Line Preferences
    private var bgView: UIView!
    
    private var relaxCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBgView()
        setupCollectionView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        bgView.setViewMask()
        bgView.frame = bgView.frame.inset(by: UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0))
    }
    
    //MARK: - Setting Up Bg View
    private func setupBgView() {
        
        bgView = UIView(frame: .zero)
        bgView.backgroundColor = .purple
        bgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgView)

        NSLayoutConstraint.activate([
            bgView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            bgView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            bgView.widthAnchor.constraint(equalTo: view.widthAnchor),
            bgView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    //MARK: - Setting Up Relax Collection View
    private func setupCollectionView() {
        
        relaxCollectionView = RelaxCollectionView(layout: createCompostionalLayout())
        relaxCollectionView.contentInset = UIEdgeInsets(top: 40, left: 0, bottom: 0, right: 0)
        relaxCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bgView.addSubview(relaxCollectionView)
        
        NSLayoutConstraint.activate([
            relaxCollectionView.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 40),
            relaxCollectionView.bottomAnchor.constraint(equalTo: bgView.bottomAnchor),
            relaxCollectionView.widthAnchor.constraint(equalTo: bgView.widthAnchor),
            relaxCollectionView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor)
        ])
    }
    
}

extension RelaxViewController {
    func createCompostionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnv) -> NSCollectionLayoutSection? in
            
            let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.3))
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = NSDirectionalEdgeInsets(top: -RelaxCell.cellCurveHeight, leading: 0, bottom: 0, trailing: 0)
            
            let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
            
            let section = NSCollectionLayoutSection(group: group)
            return section
        }
        
        return layout
    }
}
