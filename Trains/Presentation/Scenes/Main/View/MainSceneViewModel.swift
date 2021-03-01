//
//  MainSceneViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

typealias GetAllStationsType = (Result<GetAllStationsUseCase.Response, Error>) -> Void
typealias GetCurrentTrainsType = (Result<GetCurrentTrainsUseCase.Response, Error>) -> Void
typealias GetStationDataByNameType = (Result<GetStationDataByNameUseCase.Response, Error>) -> Void
typealias GetStationDataByCodeType = (Result<GetStationDataByCodeUseCase.Response, Error>) -> Void

struct MainSceneViewModelCallbacks {
    let onItemSelected: (_ id: String) -> Void
}

protocol MainSceneViewModelable {
    
    func getAllStations(_ request: GetAllStationsRequest,
                        _ completion: @escaping GetAllStationsType) -> NetworkCancellable?
    
    func getCurrentTrains(_ request: GetCurrentTrainsRequest,
                          _ completion: @escaping GetCurrentTrainsType) -> NetworkCancellable?
    
    func getStationDataByName(_ request: GetStationDataByNameRequest,
                              _ completion: @escaping GetStationDataByNameType) -> NetworkCancellable?
    func getStationDataByCode(_ request: GetStationDataByCodeRequest,
                              _ completion: @escaping GetStationDataByCodeType) -> NetworkCancellable?
    
    func didSelectItem(_ id: String)
    
}

class MainSceneViewModel: MainSceneViewModelable, ItemCellViewModelParent {
    
    // MARK: - Private Properties
    
    private let callbacks: MainSceneViewModelCallbacks!
    private let getAllStationsUseCase: GetAllStationsUseCase!
    private let getCurrentTrainsUseCase: GetCurrentTrainsUseCase!
    private let getStationDataByNameUseCase: GetStationDataByNameUseCase!
    private let getStationDataByCodeUseCase: GetStationDataByCodeUseCase!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: MainSceneViewModelCallbacks,
         _ getAllStationsUseCase: GetAllStationsUseCase,
         _ getCurrentTrainsUseCase: GetCurrentTrainsUseCase,
         _ getStationDataByNameUseCase: GetStationDataByNameUseCase,
         _ getStationDataByCodeUseCase: GetStationDataByCodeUseCase) {
        self.callbacks = callbacks
        self.getAllStationsUseCase = getAllStationsUseCase
        self.getCurrentTrainsUseCase = getCurrentTrainsUseCase
        self.getStationDataByNameUseCase = getStationDataByNameUseCase
        self.getStationDataByCodeUseCase = getStationDataByCodeUseCase
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
    
    func getStationDataByName(_ request: GetStationDataByNameRequest,
                              _ completion: @escaping GetStationDataByNameType) -> NetworkCancellable? {
        getStationDataByNameUseCase.execute(request, completion)
    }
    
    func getStationDataByCode(_ request: GetStationDataByCodeRequest,
                              _ completion: @escaping GetStationDataByCodeType) -> NetworkCancellable? {
        getStationDataByCodeUseCase.execute(request, completion)
    }
    
    func didSelectItem(_ id: String) {
        callbacks.onItemSelected(id)
    }
    
}
