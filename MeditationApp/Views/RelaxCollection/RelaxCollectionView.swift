//
//  RelaxCollectionView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 14.06.2021.
//

import UIKit

class RelaxCollectionView: UICollectionView {
    
    private var cellsImages: [UIImage] = []
    
    // Curve Line Preferences
    private var centerWidth: CGFloat!
    private var curveHeight: CGFloat = 40
    private var curveCornerRadius: CGFloat = 15
    
    init(layout: UICollectionViewLayout) {
        super.init(frame: .zero, collectionViewLayout: layout)
        
        contentInset = UIEdgeInsets(top: RelaxCell.cellCurveHeight, left: 0, bottom: 0, right: 0)
                        
        let desertImage = UIImage(named: "desert")!
        let forestImage = UIImage(named: "forest")!
        let fieldImage = UIImage(named: "field")!
                
        cellsImages = [desertImage, forestImage, fieldImage, forestImage, fieldImage, desertImage]
        
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        
        dataSource = self
        delegate = self
        register(RelaxCell.self, forCellWithReuseIdentifier: RelaxCell.relaxCellReuseId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RelaxCollectionView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RelaxCell.relaxCellReuseId, for: indexPath) as! RelaxCell
        
        cell.bgImage.image = cellsImages[indexPath.row]
        cell.layer.zPosition = CGFloat(indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: ((frame.height - curveHeight) / 3))
    }
}
