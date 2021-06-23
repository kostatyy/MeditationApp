//
//  RelaxSectionViewController.swift
//  MeditationApp
//
//  Created by Macbook Pro on 15.06.2021.
//

import UIKit

class RelaxSectionViewController: UIViewController {

    var viewModel: RelaxSectionViewModel!
    
    // Views
    private var visualEffectView = UIVisualEffectView()
    private var bgImage: UIImageView!
    private var titleStackView = UIStackView()
    private var sectionTitle = UILabel()
    private var sectionDescr = UILabel()
    
    private var blurView: RelaxSongsView! // Bluer View With Songs
    private var fullPlayerView: RelaxFullPlayerView! // Full Player View
    
    // Constraints For Animation
    private var stackCenterXConstraint: NSLayoutConstraint?
    private var blurViewTopConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .gray
        customizeNavBarBackButton()

        setupBgImage()
        setupViews()
        setupLayouts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showFullPlayer(notification:)), name: NSNotification.Name(rawValue: "PlayerViewTapNotification"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideFullPlayer(notification:)), name: NSNotification.Name(rawValue: "ClosingFullPlayer"), object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        animateViewsAppearing()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        animateViewsDisappearing()
    }
    
    private func setupBgImage() {
        bgImage = UIImageView(frame: view.bounds)
        bgImage.image = UIImage(named: "forest")
        bgImage.contentMode = .scaleAspectFill
        
        view.addSubview(bgImage)
    }
    
    private func setupViews() {
        visualEffectView.frame = view.bounds
        visualEffectView.effect = nil
        visualEffectView.layer.zPosition = 5
        view.addSubview(visualEffectView)
        
        titleStackView.axis = .vertical
        titleStackView.alpha = 0
        
        sectionTitle.text = "Meditation"
        sectionTitle.font = .setFont(size: .ExtraLarge)
        sectionTitle.textColor = .white
        sectionTitle.textAlignment = .center
        
        sectionDescr.text = "Find your happiness"
        sectionDescr.font = .setFont(size: .Large, weight: .Light)
        sectionDescr.textColor = .white
        sectionDescr.textAlignment = .center

        blurView = RelaxSongsView(frame: .zero, tracksList: viewModel.tracksList)
        blurView.alpha = 0
        
        fullPlayerView = RelaxFullPlayerView(frame: .zero, tracksList: viewModel.tracksList, activeTrack: 0)
        fullPlayerView.layer.zPosition = 10
        fullPlayerView.transform = CGAffineTransform(translationX: 0, y: view.frame.height * 0.85)
        fullPlayerView.isUserInteractionEnabled = true
        fullPlayerView.alpha = 0
        
        [titleStackView, sectionTitle, sectionDescr, blurView, fullPlayerView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupLayouts() {
        view.addSubview(titleStackView)
        titleStackView.addArrangedSubview(sectionTitle)
        titleStackView.addArrangedSubview(sectionDescr)
        view.addSubview(blurView)
        view.addSubview(fullPlayerView)
        
        blurView.pinToEdges(edges: [.bottom, .left, .right])
        
        stackCenterXConstraint = titleStackView.centerXAnchor.constraint(equalTo: view.leftAnchor, constant: 0)
        stackCenterXConstraint?.isActive = true
        
        blurViewTopConstraint = blurView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        blurViewTopConstraint?.isActive = true
        
        NSLayoutConstraint.activate([
            titleStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleStackView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.9),
            
            fullPlayerView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            fullPlayerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.85),
            fullPlayerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullPlayerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

//MARK: - Views Appearing/Disappearing Animation
extension RelaxSectionViewController {
    private func animateViewsAppearing() {
        stackCenterXConstraint?.constant = view.frame.width / 2
        blurViewTopConstraint?.constant = -view.frame.height * 0.6
        
        UIView.animate(withDuration: 0.8, delay: 0.1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut) {
            
            self.titleStackView.alpha = 1
            self.blurView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateViewsDisappearing() {
        stackCenterXConstraint?.constant = 0
        blurViewTopConstraint?.constant = 0
        
        UIView.animate(withDuration: 3, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut) {
            
            self.titleStackView.alpha = 0
            self.blurView.alpha = 0
            self.view.layoutIfNeeded()
        }
    }
}

//MARK: - Show Player Screen
extension RelaxSectionViewController {
    @objc private func showFullPlayer(notification: NSNotification) {
        navigationController?.setNavigationBarHidden(true, animated: true)
        UIView.animate(withDuration: 0.5) {
            self.fullPlayerView.alpha = 1
            self.fullPlayerView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.visualEffectView.effect = UIBlurEffect(style: .dark)
        }
    }
    
    @objc private func hideFullPlayer(notification: NSNotification) {
        navigationController?.setNavigationBarHidden(false, animated: true)
        UIView.animate(withDuration: 0.5) {
            self.fullPlayerView.alpha = 0
            self.fullPlayerView.transform = CGAffineTransform(translationX: 0, y: self.fullPlayerView.frame.height)
            self.visualEffectView.effect = nil
        }
    }
}
