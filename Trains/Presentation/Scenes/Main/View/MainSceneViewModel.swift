//
//  MainSceneViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

struct MainSceneViewModelCallbacks {
    let searchStationDidPress: () -> Void
    let searchTrainDidPress: () -> Void
}

protocol MainSceneViewModelable {
    
    func getSceneTitle() -> String
    func getSearchStationButtonTitle() -> String
    func getSearchTrainButtonTitle() -> String
    
    func searchStationDidPress()
    func searchTrainDidPress()
    
}

class MainSceneViewModel: MainSceneViewModelable, SelectStationCellViewModelParent {
    
    // MARK: - Private Properties
    
    private let callbacks: MainSceneViewModelCallbacks!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: MainSceneViewModelCallbacks) {
        self.callbacks = callbacks
    }
    
    func getSceneTitle() -> String {
        "lstr_main_scene_title".localized()
    }
    
    func getSearchStationButtonTitle() -> String {
        "lstr_main_scene_search_for_station".localized()
    }
    
    func getSearchTrainButtonTitle() -> String {
        "lstr_main_scene_search_for_train".localized()
    }
    
    func searchStationDidPress() {
        callbacks.searchStationDidPress()
    }
    
    func searchTrainDidPress() {
        callbacks.searchTrainDidPress()
    }
    
}
