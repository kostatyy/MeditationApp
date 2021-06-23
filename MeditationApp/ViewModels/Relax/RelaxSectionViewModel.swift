//
//  RelaxSectionViewModel.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import Foundation

class RelaxSectionViewModel {
    
    var coordinator: RelaxSectionCoordinator!
    var tracksList: [TrackInfo] = []
    
    func configure() {
        tracksList = [
            TrackInfo(trackName: "Behavior of the mind", trackArtist: "Eric B. & Rakim", trackMinutes: 2, trackSeconds: 4),
            TrackInfo(trackName: "Yout inner voice", trackArtist: "Ludacris", trackMinutes: 1, trackSeconds: 34),
            TrackInfo(trackName: "Embrace your emotions", trackArtist: "Justin Bieber", trackMinutes: 3, trackSeconds: 28),
            TrackInfo(trackName: "Beyoud me in", trackArtist: "Scorpion - Drake", trackMinutes: 2, trackSeconds: 16),
            TrackInfo(trackName: "Peach mid", trackArtist: "Ariana Grande", trackMinutes: 3, trackSeconds: 56),
            TrackInfo(trackName: "Shape of you", trackArtist: "Ed Sheeran", trackMinutes: 3, trackSeconds: 2),
            TrackInfo(trackName: "Rap God", trackArtist: "Eminem", trackMinutes: 2, trackSeconds: 45)
        ]
    }
    
}
