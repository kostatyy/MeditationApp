//
//  RelaxBgView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 17.06.2021.
//

import UIKit

class RelaxBgView: UIView {
    
    // Profile Image View
    private var profileImage = UIImageView()
    
    // Curve Line Preferences
    private var centerWidth: CGFloat!
    private let curveCornerRadius: CGFloat = 15
    static let curveHeight: CGFloat = 40
    static let curveInset: CGFloat = 7
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
        setupImage()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        centerWidth = frame.width / 2
        setViewMask()
        
        profileImage.layer.cornerRadius = profileImage.frame.width / 2
    }
    
    private func configure() {
        backgroundColor = .purple
    }
    
    private func setupImage() {
        profileImage.image = UIImage(named: "forest")
        profileImage.contentMode = .scaleAspectFill
        profileImage.layer.borderWidth = 2
        profileImage.layer.borderColor = UIColor.white.cgColor
        profileImage.layer.masksToBounds = true
        profileImage.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(profileImage)

        NSLayoutConstraint.activate([
            profileImage.topAnchor.constraint(equalTo: topAnchor, constant: RelaxBgView.curveInset),
            profileImage.heightAnchor.constraint(equalToConstant: RelaxBgView.curveHeight * 1.6),
            profileImage.widthAnchor.constraint(equalTo: profileImage.heightAnchor),
            profileImage.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Setting View Mask
extension RelaxBgView {
    func setViewMask() {
        let path = UIBezierPath()
        
        // Top Left Corner
        path.move(to: CGPoint(x: 0, y: curveCornerRadius + RelaxBgView.curveHeight))
        path.addArc(withCenter: CGPoint(x: curveCornerRadius, y: curveCornerRadius + RelaxBgView.curveHeight),
                    radius: curveCornerRadius,
                    startAngle: .pi / 2,
                    endAngle: -.pi / 2,
                    clockwise: true)
        
        // Top Curve Line
        path.addLine(to: CGPoint(x: centerWidth - RelaxBgView.curveHeight * 2.5, y: RelaxBgView.curveHeight))
        path.addCurve(to: CGPoint(x: centerWidth, y: 0),
                      controlPoint1: CGPoint(x: centerWidth - 30, y: RelaxBgView.curveHeight),
                      controlPoint2: CGPoint(x: centerWidth - 35, y: 0))
        path.addCurve(to: CGPoint(x: centerWidth + RelaxBgView.curveHeight * 2.5, y: RelaxBgView.curveHeight),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: 0),
                      controlPoint2: CGPoint(x: centerWidth + 30, y: RelaxBgView.curveHeight))
        
        // Top Right Corner
        path.addLine(to: CGPoint(x: frame.width - curveCornerRadius, y: RelaxBgView.curveHeight))
        path.addArc(withCenter: CGPoint(x: frame.width - curveCornerRadius, y: curveCornerRadius + RelaxBgView.curveHeight),
                    radius: curveCornerRadius,
                    startAngle: -.pi / 2,
                    endAngle: 0,
                    clockwise: true)
        
        
        path.addLine(to: CGPoint(x: frame.width, y: frame.height))
        path.addLine(to: CGPoint(x: 0, y: frame.height))
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
