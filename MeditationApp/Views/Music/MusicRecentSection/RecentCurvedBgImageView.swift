//
//  RecentCurvedBgImageView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 18.06.2021.
//

import UIKit

class RecentCurvedBgImageView: UIImageView {
    
    // Curve Preferences
    private var curveHeightMaxMultipler: CGFloat = 1
    private var curveHeightMidMultipler: CGFloat = 0.75
    private var curveHeightMinMultipler: CGFloat = 0.5
    
    // Views
    private var recentTitle = UILabel()
    private var recentListeners = UILabel()
    private var vStack = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupViews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupLayouts()
        setBgImageMask()
    }
    
    private func configure() {
        image = UIImage(named: "desert")
        contentMode = .scaleAspectFill
    }
    
    private func setupViews() {
        recentTitle.text = "7 rings - Ariana Grande"
        recentTitle.textColor = .white
        recentTitle.font = UIFont.setFont(size: .Largest, weight: .Bold)
        
        recentListeners.text = "1.450.000 K"
        recentListeners.textColor = .white
        recentListeners.font = UIFont.setFont(size: .Medium)
        
        vStack.axis = .vertical
        vStack.spacing = 7
        
        [recentTitle, recentListeners, vStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayouts() {
        addSubview(vStack)
        vStack.addArrangedSubview(recentTitle)
        vStack.addArrangedSubview(recentListeners)
        
        NSLayoutConstraint.activate([
            vStack.bottomAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.75 - 20),
            vStack.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width * 0.1),
            vStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setting Up Image Curve Mask With Animation
extension RecentCurvedBgImageView {
    private func setBgImageMask() {
        let viewWith = frame.width
        let viewHeight = frame.height
        
        let path = UIBezierPath()
        let path1 = UIBezierPath()

        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: viewWith, y: 0))
        path.addLine(to: CGPoint(x: viewWith, y: viewHeight * 0.5))
        path.addQuadCurve(to: CGPoint(x: viewWith * 0.55, y: viewHeight * curveHeightMidMultipler),
                          controlPoint: CGPoint(x: viewWith, y: viewHeight * curveHeightMinMultipler))
        path.addQuadCurve(to: CGPoint(x: 0, y: viewHeight),
                          controlPoint: CGPoint(x: 0, y: viewHeight * curveHeightMaxMultipler))
        path.close()
        
        path1.move(to: CGPoint(x: 0, y: 0))
        path1.addLine(to: CGPoint(x: viewWith, y: 0))
        path1.addLine(to: CGPoint(x: viewWith, y: viewHeight * 0.5))
        path1.addQuadCurve(to: CGPoint(x: viewWith * 0.55, y: viewHeight * curveHeightMidMultipler),
                          controlPoint: CGPoint(x: viewWith, y: viewHeight * curveHeightMidMultipler))
        path1.addQuadCurve(to: CGPoint(x: 0, y: viewHeight),
                          controlPoint: CGPoint(x: 0, y: viewHeight * curveHeightMidMultipler))
        path1.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        let anim = CABasicAnimation(keyPath: "path")
        anim.fromValue = path.cgPath
        anim.toValue = path1.cgPath
        anim.duration = 0.5
        
        anim.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        
        layer.mask?.add(anim, forKey: nil)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        mask.path = path1.cgPath
        CATransaction.commit()
        
    }
}
