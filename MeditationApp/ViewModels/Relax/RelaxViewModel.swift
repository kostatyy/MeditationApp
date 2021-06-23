//
//  RelaxViewModel.swift
//  MeditationApp
//
//  Created by Macbook Pro on 16.06.2021.
//

import Foundation

class RelaxViewModel {
    
    var coordinator: RelaxCoordinator!
    
    //MARK: - Handling Section Selection
    func sectionSelected() {
        coordinator.goToSelectedSection()
    }
}
