//
//  MainSceneViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

typealias GetAllStationsType = (Result<GetAllStationsUseCase.Response, Error>) -> Void
typealias GetCurrentTrainsType = (Result<GetCurrentTrainsUseCase.Response, Error>) -> Void

struct MainSceneViewModelCallbacks {
    let onItemSelected: (_ id: String) -> Void
}

protocol MainSceneViewModelable {
    
    func getAllStations(_ request: GetAllStationsRequest,
                        _ completion: @escaping GetAllStationsType) -> NetworkCancellable?
    
    func getCurrentTrains(_ request: GetCurrentTrainsRequest,
                          _ completion: @escaping GetCurrentTrainsType) -> NetworkCancellable?
    
    func didSelectItem(_ id: String)
    
}

class MainSceneViewModel: MainSceneViewModelable, ItemCellViewModelParent {
    
    // MARK: - Private Properties
    
    private let callbacks: MainSceneViewModelCallbacks!
    private let getAllStationsUseCase: GetAllStationsUseCase!
    private let getCurrentTrainsUseCase: GetCurrentTrainsUseCase!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: MainSceneViewModelCallbacks,
         _ getAllStationsUseCase: GetAllStationsUseCase,
         _ getCurrentTrainsUseCase: GetCurrentTrainsUseCase) {
        self.callbacks = callbacks
        self.getAllStationsUseCase = getAllStationsUseCase
        self.getCurrentTrainsUseCase = getCurrentTrainsUseCase
    }
    
    // MARK: - Public API -
    
    func getAllStations(_ request: GetAllStationsRequest,
                        _ completion: @escaping GetAllStationsType) -> NetworkCancellable? {
        getAllStationsUseCase.execute(request, completion)
    }
    
    func getCurrentTrains(_ request: GetCurrentTrainsRequest,
                          _ completion: @escaping GetCurrentTrainsType) -> NetworkCancellable? {
        getCurrentTrainsUseCase.execute(request, completion)
    }
    
    func didSelectItem(_ id: String) {
        callbacks.onItemSelected(id)
    }
    
}
