//
//  RelaxPlayerView.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

enum PlayerState {
    case Play, Pause
}

class RelaxPlayerView: UIView {
    
    // Curve Preferences
    private let curveLeftEdge: CGFloat = 30
    private let curveRightEdge: CGFloat = 35
    private var curveHeight: CGFloat!
    private var curveCenter: CGFloat!
    private var curveOriginalPath: UIBezierPath!

    // Play Button
    private var playButtonView = UIView()
    private var playButtonImage = UIImageView()
    private var playerState = PlayerState.Pause
    
    // Current Track
    private var playingTrack = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePlayingTrack(notification:)), name: NSNotification.Name(rawValue: "SelectingPlayingTrack"), object: nil)
        configure()
    }
    
    /* Setup View Configuration */
    private func configure() {
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePanGestureOnBlurView(sender:))))
        addBlurEffect(style: .dark)
        playButtonView.addBlurEffect(style: .dark)
        playButtonView.layer.masksToBounds = true
        
        playButtonImage.image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
        playButtonImage.isUserInteractionEnabled = true
        playButtonImage.contentMode = .scaleAspectFit
        playButtonImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handlePlayerState)))
        
        [playButtonView, playButtonImage].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        curveHeight = frame.height / 2
        curveCenter = frame.width - curveHeight - curveRightEdge
        setPlayerMask()
        setupPlayerButton()
        setupPlayingTrack()
        playButtonView.layer.cornerRadius = playButtonView.frame.width / 2
    }
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        setPlayerMask()
    }
    
    /* Setting Up Play Button */
    private func setupPlayerButton() {
        
        superview?.addSubview(playButtonView)
        playButtonView.addSubview(playButtonImage)
        
        NSLayoutConstraint.activate([
            playButtonView.widthAnchor.constraint(equalToConstant: (curveHeight * 2) - (curveRightEdge - curveLeftEdge)),
            playButtonView.heightAnchor.constraint(equalTo: playButtonView.widthAnchor),
            playButtonView.centerXAnchor.constraint(equalTo: rightAnchor, constant: -(curveHeight + curveRightEdge)),
            playButtonView.centerYAnchor.constraint(equalTo: topAnchor, constant: -5),
            
            playButtonImage.widthAnchor.constraint(equalTo: playButtonView.widthAnchor, multiplier: 0.25),
            playButtonImage.heightAnchor.constraint(equalTo: playButtonView.widthAnchor),
            playButtonImage.centerXAnchor.constraint(equalTo: playButtonView.centerXAnchor),
            playButtonImage.centerYAnchor.constraint(equalTo: playButtonView.centerYAnchor),
        ])
    }
    
    private func setupPlayingTrack() {
        playingTrack.font = UIFont.setFont(size: .Medium)
        playingTrack.addKern(1.5)
        playingTrack.textColor = .white
        playingTrack.alpha = 0.7
        playingTrack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(playingTrack)
        
        NSLayoutConstraint.activate([
            playingTrack.leftAnchor.constraint(equalTo: leftAnchor, constant: frame.width * 0.05),
            playingTrack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    /* Handling Pan Gesture Recogniser On Player View */
    @objc private func handlePanGestureOnBlurView(sender: UIPanGestureRecognizer) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "PlayerViewTapNotification"), object: nil)
    }
    
    @objc private func handlePlayingTrack(notification: NSNotification) {
        guard let track = notification.userInfo!["track"] as? RelaxSongsCellViewModel else { return }
        let trackName = track.trackTitle()
        let trackDuration = track.trackDuration()
        playingTrack.text = "\(trackDuration) - \(trackName)"
    }
    
    /* Changing Player State On Tap */
    @objc private func handlePlayerState() {

        UIView.animate(withDuration: 0.15) {
            self.playButtonImage.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        } completion: { (_) in
            if self.playerState == .Play {
                self.playerState = .Pause
                self.playButtonImage.image = UIImage(systemName: "play.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
            } else {
                self.playerState = .Play
                self.playButtonImage.image = UIImage(systemName: "pause.fill")?.withRenderingMode(.alwaysOriginal).withTintColor(.white)
            }
            
            UIView.animate(withDuration: 0.15) {
                self.playButtonImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - Setting Up View Mask
extension RelaxPlayerView {
    func setPlayerMask() {
        curveOriginalPath = UIBezierPath()
        
        curveOriginalPath.move(to: CGPoint(x: 0, y: 0))
                
        curveOriginalPath.addLine(to: CGPoint(x: curveCenter - curveHeight - curveRightEdge, y: 0))
        
        // Top Curve Line
        curveOriginalPath.addCurve(to: CGPoint(x: curveCenter, y: curveHeight),
                      controlPoint1: CGPoint(x: curveCenter - curveLeftEdge, y: 0),
                      controlPoint2: CGPoint(x: curveCenter - curveRightEdge, y: curveHeight))

        curveOriginalPath.addCurve(to: CGPoint(x: frame.width, y: 0),
                      controlPoint1: CGPoint(x: curveCenter + curveRightEdge, y: curveHeight),
                      controlPoint2: CGPoint(x: curveCenter + curveLeftEdge, y: 0))
        
        curveOriginalPath.addLine(to: CGPoint(x: frame.width, y: frame.height))
        curveOriginalPath.addLine(to: CGPoint(x: 0, y: frame.height))

        curveOriginalPath.close()
        
        let mask = CAShapeLayer()
        mask.path = curveOriginalPath.cgPath
        layer.mask = mask
    }
}
