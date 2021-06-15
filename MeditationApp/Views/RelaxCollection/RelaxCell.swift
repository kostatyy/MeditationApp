//
//  RelaxCell.swift
//  MeditationApp
//
//  Created by Macbook Pro on 14.06.2021.
//

import UIKit

class RelaxCell: UICollectionViewCell {
    
    static var relaxCellReuseId = "RelaxCellId"
    static var cellCurveHeight: CGFloat = 20
    
    var bgImage = UIImageView()
    var verticalStack = UIStackView()
    var relaxTitle = UILabel()
    var relaxDescr = UILabel()
    
    let overlapHeight: CGFloat = 20
    var innerView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        setupViews()
        setupLayouts()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setCellMask()
    }
    
    private func setupViews() {
        
        innerView = UIView(frame: CGRect(x: 0, y: -overlapHeight, width: frame.width, height: frame.height + overlapHeight))
        innerView.backgroundColor = .red
        
        bgImage.contentMode = .scaleToFill
        bgImage.image = UIImage(named: "desert")
        
        verticalStack.axis = .vertical
        
        relaxTitle.text = "Meditation"
        relaxTitle.font = .setFont(size: .ExtraLarge)
        relaxTitle.textColor = .white
        relaxTitle.textAlignment = .center
        
        relaxDescr.text = "Find your happiness"
        relaxDescr.font = .setFont(size: .Large)
        relaxDescr.textColor = .white
        relaxDescr.textAlignment = .center
        
        [bgImage, verticalStack, relaxTitle, relaxDescr].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupLayouts() {
        contentView.addSubview(innerView)
        innerView.addSubview(bgImage)
        innerView.addSubview(verticalStack)
        
        verticalStack.addArrangedSubview(relaxTitle)
        verticalStack.addArrangedSubview(relaxDescr)
        
        bgImage.pinToEdges()
        
        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            verticalStack.topAnchor.constraint(equalTo: topAnchor, constant: frame.height * 0.2),
            verticalStack.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension RelaxCell {
    /* Setting Up Cell Curve Mask */
    private func setCellMask() {
        let centerWidth: CGFloat = frame.width / 2
        let curveHeight: CGFloat = RelaxCell.cellCurveHeight
        let curveCornerRadius: CGFloat = 15
        let path = UIBezierPath()
        
        // Top Left Corner
        path.move(to: CGPoint(x: 0, y: curveCornerRadius))
        path.addArc(withCenter: CGPoint(x: curveCornerRadius, y: curveCornerRadius),
                    radius: curveCornerRadius,
                    startAngle: .pi / 2,
                    endAngle: -.pi / 2,
                    clockwise: true)
                
        // Top Curve Line
        path.addCurve(to: CGPoint(x: centerWidth, y: -curveHeight),
                      controlPoint1: CGPoint(x: centerWidth - 30, y: 0),
                      controlPoint2: CGPoint(x: centerWidth - 35, y: -curveHeight))
        
        path.addCurve(to: CGPoint(x: frame.width - curveCornerRadius, y: 0),
                      controlPoint1: CGPoint(x: centerWidth + 35, y: -curveHeight),
                      controlPoint2: CGPoint(x: centerWidth + 30, y: 0))
        
        // Top Right Corner
        path.addLine(to: CGPoint(x: frame.width - curveCornerRadius, y: 0))
        path.addArc(withCenter: CGPoint(x: frame.width - curveCornerRadius, y: curveCornerRadius),
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
