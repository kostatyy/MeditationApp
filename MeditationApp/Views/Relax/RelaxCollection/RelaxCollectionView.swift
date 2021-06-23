//
//  RelaxCollectionView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 14.06.2021.
//

import UIKit

class RelaxCollectionView: UICollectionView {
    
    private var relaxViewModel: RelaxViewModel
    private var cellsImages: [UIImage] = []
    
    init(layout: UICollectionViewLayout, relaxViewModel: RelaxViewModel) {
        self.relaxViewModel = relaxViewModel
        super.init(frame: .zero, collectionViewLayout: layout)
        
        contentInset = UIEdgeInsets(top: RelaxCell.cellCurveMinHeight, left: 0, bottom: 0, right: 0)
                        
        let desertImage = UIImage(named: "desert")!
        let forestImage = UIImage(named: "forest")!
        let fieldImage = UIImage(named: "field")!
                
        cellsImages = [desertImage, forestImage, fieldImage, forestImage, fieldImage, desertImage]
        
        isScrollEnabled = false
        backgroundColor = .clear
        showsVerticalScrollIndicator = false
        
        dataSource = self
        delegate = self
        register(RelaxCell.self, forCellWithReuseIdentifier: RelaxCell.relaxCellReuseId)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Handling Pan Gesture To Slide Collection View
    @objc func handlePanGesture(sender: UIPanGestureRecognizer) {
        let velocity = sender.velocity(in: self)
                
        // Sliding Collection View
        if sender.state == .began || sender.state == .changed {
            let velocityYInfo: [String: CGFloat] = ["yInfo": velocity.y]
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeCurvedLine"), object: nil, userInfo: velocityYInfo)
        }
        
        // Ended Sliding Collection View
        if sender.state == .ended {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "EndedChangingCurvedLine"), object: nil, userInfo: nil)
//            scrollToItem(at: IndexPath(item: 4, section: 0), at: .centeredVertically, animated: false)
        }
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        relaxViewModel.sectionSelected()
        
//        if (indexPath.row + 1) % 3 == 0, (indexPath.row + 2) < cellsImages.count {
//            scrollToItem(at: IndexPath(item: indexPath.row + 2, section: 0), at: .centeredVertically, animated: false)
//        }
    }
}
