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
typealias GetStationsFilterType = (Result<GetStationsFilterUseCase.Response, Error>) -> Void
typealias GetTrainsMovementsType = (Result<GetTrainMovementsUseCase.Response, Error>) -> Void

struct MainSceneViewModelCallbacks {
    let onItemSelected: (_ id: String) -> Void
}

protocol MainSceneViewModelable {
    
    @discardableResult
    func getAllStations(type: StationType?,
                        _ completion: @escaping GetAllStationsType) -> NetworkCancellable?
    
    @discardableResult
    func getCurrentTrains(type: TrainType?,
                          _ completion: @escaping GetCurrentTrainsType) -> NetworkCancellable?
    
    @discardableResult
    func getStationDataByName(name: String,
                              minutes: Int?,
                              _ completion: @escaping GetStationDataByNameType) -> NetworkCancellable?
    
    @discardableResult
    func getStationDataByCode(code: String,
                              minutes: Int?,
                              _ completion: @escaping GetStationDataByCodeType) -> NetworkCancellable?
    
    @discardableResult
    func getStationsFilter(filter: String,
                           _ completion: @escaping GetStationsFilterType) -> NetworkCancellable?
    
    @discardableResult
    func getTrainMovements(id: String,
                           date: Date,
                           _ completion: @escaping GetTrainsMovementsType) -> NetworkCancellable?
    
    func didSelectItem(_ id: String)
    
}

class MainSceneViewModel: MainSceneViewModelable, ItemCellViewModelParent {
    
    // MARK: - Private Properties
    
    private let callbacks: MainSceneViewModelCallbacks!
    private let getAllStationsUseCase: GetAllStationsUseCase!
    private let getCurrentTrainsUseCase: GetCurrentTrainsUseCase!
    private let getStationDataByNameUseCase: GetStationDataByNameUseCase!
    private let getStationDataByCodeUseCase: GetStationDataByCodeUseCase!
    private let getStationsFilterUseCase: GetStationsFilterUseCase!
    private let getTrainMovementsUseCase: GetTrainMovementsUseCase!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: MainSceneViewModelCallbacks,
         _ getAllStationsUseCase: GetAllStationsUseCase,
         _ getCurrentTrainsUseCase: GetCurrentTrainsUseCase,
         _ getStationDataByNameUseCase: GetStationDataByNameUseCase,
         _ getStationDataByCodeUseCase: GetStationDataByCodeUseCase,
         _ getStationsFilterUseCase: GetStationsFilterUseCase,
         _ getTrainMovementsUseCase: GetTrainMovementsUseCase) {
        self.callbacks = callbacks
        self.getAllStationsUseCase = getAllStationsUseCase
        self.getCurrentTrainsUseCase = getCurrentTrainsUseCase
        self.getStationDataByNameUseCase = getStationDataByNameUseCase
        self.getStationDataByCodeUseCase = getStationDataByCodeUseCase
        self.getStationsFilterUseCase = getStationsFilterUseCase
        self.getTrainMovementsUseCase = getTrainMovementsUseCase
    }
    
    // MARK: - Public API -
    
    @discardableResult
    func getAllStations(type: StationType?,
                        _ completion: @escaping GetAllStationsType) -> NetworkCancellable? {
        let request = GetAllStationsRequest(type: type)
        return getAllStationsUseCase.execute(request, completion)
    }
    
    @discardableResult
    func getCurrentTrains(type: TrainType?,
                          _ completion: @escaping GetCurrentTrainsType) -> NetworkCancellable? {
        let request = GetCurrentTrainsRequest(type: type)
        return getCurrentTrainsUseCase.execute(request, completion)
    }
    
    @discardableResult
    func getStationDataByName(name: String,
                              minutes: Int?,
                              _ completion: @escaping GetStationDataByNameType) -> NetworkCancellable? {
        let request = GetStationDataByNameRequest(name: name, minutes: minutes)
        return getStationDataByNameUseCase.execute(request, completion)
    }
    
    @discardableResult
    func getStationDataByCode(code: String,
                              minutes: Int?,
                              _ completion: @escaping GetStationDataByCodeType) -> NetworkCancellable? {
        let request = GetStationDataByCodeRequest(code: code, minutes: minutes)
        return getStationDataByCodeUseCase.execute(request, completion)
    }
    
    @discardableResult
    func getStationsFilter(filter: String,
                           _ completion: @escaping GetStationsFilterType) -> NetworkCancellable? {
        let request = GetStationsFilterRequest(filter: filter)
        return getStationsFilterUseCase.execute(request, completion)
    }
    
    @discardableResult
    func getTrainMovements(id: String,
                           date: Date,
                           _ completion: @escaping GetTrainsMovementsType) -> NetworkCancellable? {
        let _date = DateFormatter.trainMovementsDateFormatter.string(from: date)
        let request = GetTrainMovementsRequest(id: id, date: _date)
        return getTrainMovementsUseCase.execute(request, completion)
    }
    
    func didSelectItem(_ id: String) {
        callbacks.onItemSelected(id)
    }
    
}
