//
//  MusicViewModel.swift
//  MeditationApp
//
//  Created by Macbook Pro on 17.06.2021.
//

import UIKit

class MusicViewModel {
    
    var coordinator: MusicCoordinator!
    
    func recentMusicSelected() {
        coordinator.goToRecentlySection()
    }
    
}
