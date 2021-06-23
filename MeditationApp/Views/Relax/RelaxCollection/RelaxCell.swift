//
//  RelaxCell.swift
//  MeditationApp
//
//  Created by Macbook Pro on 14.06.2021.
//

import UIKit

class RelaxCell: UICollectionViewCell {
    
    // Static Vars
    static var relaxCellReuseId = "RelaxCellId"
    static var cellCurveMinHeight: CGFloat = 20
    static var cellCurveMaxHeight: CGFloat = 20
    
    // Views
    var bgImage = UIImageView()
    var verticalStack = UIStackView()
    var relaxTitle = UILabel()
    var relaxDescr = UILabel()
    
    // Curve Line Preferences
    private var overlapHeight: CGFloat = 20
    private var innerView: UIView!
    private var curveHeightChange: CGFloat = 0
    private var curveLeftEdge: CGFloat = 30
    private var curveRightEdge: CGFloat = 35
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                
        innerView = UIView(frame: CGRect(x: 0, y: -self.overlapHeight, width: self.frame.width, height: self.frame.height + self.overlapHeight))
        
        setupViews()
        setupLayouts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeCurvedLine(notification:)), name: NSNotification.Name(rawValue: "ChangeCurvedLine"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(endChangeCurvedLine(notification:)), name: NSNotification.Name(rawValue: "EndedChangingCurvedLine"), object: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        setCellMask()
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
//        guard let superview = self.superview as? UICollectionView else { return }
//        let index = superview.indexPath(for: self)?.row
        
        //MARK: - Curve Line Animation While Sliding
        if ((RelaxCell.cellCurveMinHeight < 50 || curveHeightChange <= 0) &&
                (RelaxCell.cellCurveMinHeight > 20 || curveHeightChange >= 0)) {

            RelaxCell.cellCurveMinHeight += curveHeightChange
            curveLeftEdge += (curveHeightChange * 2.2)
            curveRightEdge = curveLeftEdge

            self.overlapHeight = RelaxCell.cellCurveMinHeight
            self.innerView = UIView(frame: CGRect(x: 0, y: -self.overlapHeight, width: self.frame.width, height: self.frame.height + self.overlapHeight))
            self.setupLayouts()
        }
    }
    
    @objc private func changeCurvedLine(notification: NSNotification) {
        guard let yInfo = notification.userInfo?["yInfo"] as? CGFloat else {return}
        curveHeightChange = 0 - (yInfo / 720)
        layoutIfNeeded()
    }
    
    @objc private func endChangeCurvedLine(notification: NSNotification?) {
        RelaxCell.cellCurveMinHeight = 20
        self.curveHeightChange = 0
        self.curveLeftEdge = 30
        self.curveRightEdge = 35
        self.overlapHeight = RelaxCell.cellCurveMinHeight
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut) {
            self.layoutIfNeeded()
        }
    }
        
    private func setupViews() {
        bgImage.contentMode = .scaleToFill
        bgImage.image = UIImage(named: "desert")
        
        verticalStack.axis = .vertical
        
        relaxTitle.text = "Meditation"
        relaxTitle.font = .setFont(size: .ExtraLarge)
        relaxTitle.textColor = .white
        relaxTitle.textAlignment = .center
        
        relaxDescr.text = "Find your happiness"
        relaxDescr.font = .setFont(size: .Large, weight: .Light)
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
            verticalStack.centerXAnchor.constraint(equalTo: innerView.centerXAnchor),
            verticalStack.topAnchor.constraint(equalTo: innerView.topAnchor, constant: innerView.frame.height * 0.2),
            verticalStack.widthAnchor.constraint(equalTo: innerView.widthAnchor, multiplier: 0.8),
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
        let curveHeight: CGFloat = RelaxCell.cellCurveMinHeight
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
                      controlPoint1: CGPoint(x: centerWidth - curveLeftEdge, y: 0),
                      controlPoint2: CGPoint(x: centerWidth - curveRightEdge, y: -curveHeight))
        
        path.addCurve(to: CGPoint(x: frame.width - curveCornerRadius, y: 0),
                      controlPoint1: CGPoint(x: centerWidth + curveRightEdge, y: -curveHeight),
                      controlPoint2: CGPoint(x: centerWidth + curveLeftEdge, y: 0))
        
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
