//
//  TapNavigationMenu.swift
//  MeditationApp
//
//  Created by Macbook Pro on 13.06.2021.
//

import UIKit

class TabNavigationMenu: UIView {
    
    var itemTapped: ((_ tab: Int) -> Void)?
    var activeItem: Int = 0
    
    // Curved View
    private var curvedView = UIView(frame: .zero)
    private var curvedViewHeightMultipler: CGFloat = 0.6
    private var tabBarWidth: CGFloat!
    private var tabBarHeight: CGFloat!
    
    // Circle Views
    private var circleViews: [UIView] = []
    private var musicCircle = UIView(frame: .zero)
    private var relaxCircle = UIView(frame: .zero)
    private var dreamCircle = UIView(frame: .zero)
    
    // Item Titles
    private var itemTitles: [UILabel] = []
        
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    convenience init(menuItems: [TabItem], frame: CGRect) {
        self.init(frame: frame)
        
        tabBarWidth = frame.width
        tabBarHeight = frame.height
        
        itemTitles = [UILabel(), UILabel(), UILabel()]
        circleViews = [musicCircle, relaxCircle, dreamCircle]
        
        setupCurvedView()
        
        for i in 0 ..< menuItems.count {
            let itemWidth = self.frame.width / CGFloat(menuItems.count)
            let leadingAnchor = (itemWidth * CGFloat(i)) + (frame.width / 6)
            
            let itemView = self.createTabItem(item: menuItems[i], itemIconBgView: &circleViews[i], itemTitleLabel: &itemTitles[i], titleLeftAnchorConstant: leadingAnchor)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            itemView.clipsToBounds = true
            itemView.tag = i
            self.addSubview(itemView)
            
            NSLayoutConstraint.activate([
                itemView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5),
                itemView.centerXAnchor.constraint(equalTo: self.leadingAnchor, constant: leadingAnchor),
                itemView.topAnchor.constraint(equalTo: self.topAnchor),
                itemView.bottomAnchor.constraint(equalTo: curvedView.centerYAnchor, constant: tabBarHeight / 3)
            ])
        }
        
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        circleViews.forEach {
            $0.layer.cornerRadius = $0.frame.width / 2
        }
        activateTab(tab: 1)
    }
    
    func createTabItem(item: TabItem, itemIconBgView: inout UIView, itemTitleLabel: inout UILabel, titleLeftAnchorConstant: CGFloat) -> UIView {
        
        let tabBarItem = UIView(frame: CGRect.zero)
        let itemIconView = UIImageView(frame: CGRect.zero)
        
        itemTitleLabel.text = item.displayTitle
        itemTitleLabel.alpha = 0
        itemTitleLabel.textColor = .white
        itemTitleLabel.textAlignment = .center
        itemTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        itemTitleLabel.clipsToBounds = true
        
        itemIconBgView.addBlurEffect(style: .dark)
        itemIconBgView.translatesAutoresizingMaskIntoConstraints = false
        itemIconBgView.clipsToBounds = true
        
        itemIconView.image = item.icon.withRenderingMode(.automatic)
        itemIconView.translatesAutoresizingMaskIntoConstraints = false
        itemIconView.clipsToBounds = true
        
        tabBarItem.layer.backgroundColor = UIColor.clear.cgColor
        
        tabBarItem.addSubview(itemIconBgView)
        itemIconBgView.addSubview(itemIconView)
        curvedView.addSubview(itemTitleLabel)
        
        tabBarItem.translatesAutoresizingMaskIntoConstraints = false
        tabBarItem.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            itemIconBgView.widthAnchor.constraint(equalTo: tabBarItem.widthAnchor),
            itemIconBgView.heightAnchor.constraint(equalTo: itemIconBgView.widthAnchor),
            itemIconBgView.centerXAnchor.constraint(equalTo: tabBarItem.centerXAnchor),
            itemIconBgView.centerYAnchor.constraint(equalTo: tabBarItem.centerYAnchor),
            
            itemIconView.heightAnchor.constraint(equalTo: itemIconBgView.heightAnchor ,multiplier: 0.4),
            itemIconView.widthAnchor.constraint(equalTo: itemIconBgView.widthAnchor, multiplier: 0.4),
            itemIconView.centerXAnchor.constraint(equalTo: itemIconBgView.centerXAnchor),
            itemIconView.centerYAnchor.constraint(equalTo: itemIconBgView.centerYAnchor),
            
            itemTitleLabel.centerXAnchor.constraint(equalTo: curvedView.leftAnchor, constant: titleLeftAnchorConstant),
            itemTitleLabel.topAnchor.constraint(equalTo: curvedView.centerYAnchor, constant: -tabBarHeight * 0.15)
        ])
        
        tabBarItem.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTap)))
        return tabBarItem
    }
    
    @objc func handleTap(_ sender: UIGestureRecognizer) {
        self.switchTab(from: self.activeItem, to: sender.view!.tag)
    }
    
    func switchTab(from: Int, to: Int) {
        self.deactivateTab(tab: from)
        self.activateTab(tab: to)
    }
    
    func activateTab(tab: Int) {
        let circleToActivate = self.circleViews[tab]
        let labelToActivate = self.itemTitles[tab]

        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            circleToActivate.transform = CGAffineTransform(translationX: 0, y: -(circleToActivate.frame.height / 5))
            labelToActivate.alpha = 1
        })
        self.itemTapped?(tab)
        self.activeItem = tab
    }
    
    func deactivateTab(tab: Int) {
        let inactiveTab = self.circleViews[tab]
        let inactiveLabel = self.itemTitles[tab]

        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn, .allowUserInteraction], animations: {
            inactiveTab.transform = CGAffineTransform(translationX: 0, y: 0)
            inactiveLabel.alpha = 0
        })
    }
}

//MARK: - Drawing Custom TabBar Shape (Cosine)
extension TabNavigationMenu {
    private func setupCurvedView() {
        curvedView.addBlurEffect(style: .systemChromeMaterialDark)

        curvedView.layer.zPosition = 2
        curvedView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(curvedView)
        
        NSLayoutConstraint.activate([
            curvedView.widthAnchor.constraint(equalTo: widthAnchor),
            curvedView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: curvedViewHeightMultipler),
            curvedView.leadingAnchor.constraint(equalTo: leadingAnchor),
            curvedView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        let amplitude: CGFloat = 0.25
        let width: CGFloat = tabBarWidth / 3
        let height: CGFloat = tabBarHeight
        
        let origin = CGPoint(x: 0, y: tabBarHeight * curvedViewHeightMultipler - height * amplitude)
        let path = UIBezierPath()
        path.move(to: origin)
        
        for angle in stride(from: 0.0, through: 1080, by: 5.0) {
            let x = origin.x + CGFloat(angle/360.0) * width
            let y = origin.y - CGFloat(cos(angle/180.0 * Double.pi)) * height * amplitude
            path.addLine(to: CGPoint(x: x, y: y))
        }
        
        path.addLine(to: CGPoint(x: tabBarWidth, y: tabBarHeight * 2))
        path.addLine(to: CGPoint(x: 0, y: tabBarHeight * 2))
        
        path.close()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        curvedView.layer.mask = mask
    }
}
