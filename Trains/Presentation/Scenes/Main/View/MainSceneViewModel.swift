//
//  MainSceneViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

typealias GetAllStationsType = (Result<GetAllStations.Response, Error>) -> Void

struct MainSceneViewModelCallbacks {
    let onItemSelected: (_ id: String) -> Void
}

protocol MainSceneViewModelable {
    func getAllStations(_ completion: @escaping GetAllStationsType) -> NetworkCancellable?
    func didSelectItem(_ id: String)
}

class MainSceneViewModel: MainSceneViewModelable, ItemCellViewModelParent {
    
    // MARK: - Private Properties
    
    private let callbacks: MainSceneViewModelCallbacks!
    private let getAllStationsUseCase: GetAllStations!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: MainSceneViewModelCallbacks,
         _ getAllStationsUseCase: GetAllStations) {
        self.callbacks = callbacks
        self.getAllStationsUseCase = getAllStationsUseCase
    }
    
    // MARK: - Public API -
    
    func getAllStations(_ completion: @escaping GetAllStationsType) -> NetworkCancellable? {
        getAllStationsUseCase.execute(nil, completion)
    }
    
    func didSelectItem(_ id: String) {
        callbacks.onItemSelected(id)
    }
    
}
