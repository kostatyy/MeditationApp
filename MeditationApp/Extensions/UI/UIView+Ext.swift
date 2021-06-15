//
//  UIView+Ext.swift
//  MeditationApp
//
//  Created by Macbook Pro on 14.06.2021.
//

import UIKit

enum Edge {
    case top
    case bottom
    case left
    case right
}

extension UIView {
    func addBlurEffect(style: UIBlurEffect.Style) {
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }

    func pinToEdges(edges: [Edge] = [.top, .bottom, .left, .right], constant: CGFloat = 0) {
        guard let superview = superview else {return}
        edges.forEach {
            switch $0 {
            case .top:
                topAnchor.constraint(equalTo: superview.topAnchor, constant: constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -constant).isActive = true
            case .left:
                leftAnchor.constraint(equalTo: superview.leftAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superview.rightAnchor, constant: -constant).isActive = true
            }
        }
    }
    
    func setViewMask() {
        let centerWidth: CGFloat = frame.width / 2
        let curveHeight: CGFloat = 40
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
        path.addLine(to: CGPoint(x: centerWidth - curveHeight * 2.5, y: 0))
        path.addCurve(to: CGPoint(x: centerWidth, y: -curveHeight),
                      controlPoint1: CGPoint(x: centerWidth - 30, y: 0),
                      controlPoint2: CGPoint(x: centerWidth - 35, y: -curveHeight))
        path.addCurve(to: CGPoint(x: centerWidth + curveHeight * 2.5, y: 0),
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
