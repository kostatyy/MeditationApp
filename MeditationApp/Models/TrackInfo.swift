//
//  TrackInfo.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import Foundation

struct TrackInfo {
    var trackName: String
    var trackArtist: String
    var trackMinutes: Int
    var trackSeconds: Int
    
    init(trackName: String, trackArtist: String, trackMinutes: Int, trackSeconds: Int) {
        self.trackName = trackName
        self.trackArtist = trackArtist
        self.trackMinutes = trackMinutes
        self.trackSeconds = trackSeconds
    }
}
