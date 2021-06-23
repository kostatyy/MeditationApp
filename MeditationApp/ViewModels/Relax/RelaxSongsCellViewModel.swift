//
//  RelaxSongsCellViewModel.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import UIKit

class RelaxSongsCellViewModel {
    
    var track: TrackInfo
    
    init(track: TrackInfo) {
        self.track = track
    }
    
    func trackTitle() -> String { return track.trackName }
    func trackDuration() -> String {
        var secondsString = ""
        secondsString += track.trackSeconds < 10 ? "0\(track.trackSeconds)" : "\(track.trackSeconds)"
        return "\(track.trackMinutes):\(secondsString)"
    }
}
