//
//  StationSceneViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 4.03.21.
//

import UIKit

typealias GetAllStationsType = (Result<StationSceneLayouts, Error>) -> Void
typealias GetStationDataByNameType = (Result<StationSceneLayouts, Error>) -> Void
typealias GetStationDataByCodeType = (Result<StationSceneLayouts, Error>) -> Void
typealias GetStationsFilterType = (Result<StationSceneLayouts, Error>) -> Void

struct StationSceneViewModelCallbacks { }

protocol StationSceneViewModelable {
    
    var searchButtonTitle: String { get }
    
    func getEmptyStateText() -> String
    func getTitle() -> String
    
    func getStationTypeSegmentTitleLabel() -> String
    func getStationSearchTypeSegmentTitleLabel() -> String
    
    @discardableResult
    func getAllStations(type: StationType?,
                        _ completion: @escaping GetAllStationsType) -> NetworkCancellable?
    
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
    
    func getStationTypes() -> [StationType]
    
}

class StationSceneViewModel: StationSceneViewModelable {
    
    private let callbacks: StationSceneViewModelCallbacks!
    private let getAllStationsUseCase: GetAllStationsUseCase!
    private let getStationDataByNameUseCase: GetStationDataByNameUseCase!
    private let getStationDataByCodeUseCase: GetStationDataByCodeUseCase!
    private let getStationsFilterUseCase: GetStationsFilterUseCase!
    
    // MARK: - ViewModel Lifecycle
    
    init(_ callbacks: StationSceneViewModelCallbacks,
         _ getAllStationsUseCase: GetAllStationsUseCase,
         _ getStationDataByNameUseCase: GetStationDataByNameUseCase,
         _ getStationDataByCodeUseCase: GetStationDataByCodeUseCase,
         _ getStationsFilterUseCase: GetStationsFilterUseCase) {
        self.callbacks = callbacks
        self.getAllStationsUseCase = getAllStationsUseCase
        self.getStationDataByNameUseCase = getStationDataByNameUseCase
        self.getStationDataByCodeUseCase = getStationDataByCodeUseCase
        self.getStationsFilterUseCase = getStationsFilterUseCase
    }
    
    // MARK: - Public API -
    
    var searchButtonTitle: String {
        "lstr_common_search".localized()
    }
    
    func getEmptyStateText() -> String {
        return "lstr_station_scene_empty_state_title".localized()
    }
    
    func getTitle() -> String {
        "lstr_station_scene_title".localized()
    }
    
    func getStationTypeSegmentTitleLabel() -> String {
        "lstr_station_scene_station_type_label".localized()
    }
    
    func getStationSearchTypeSegmentTitleLabel() -> String {
        "lstr_station_scene_station_search_type_label".localized()
    }
    
    @discardableResult
    func getAllStations(type: StationType?,
                        _ completion: @escaping GetAllStationsType) -> NetworkCancellable? {
        let request = GetAllStationsRequest(type: type)
        return getAllStationsUseCase.execute(request) { result in
            switch result {
            case .success(let data):
                let layouts = StationSceneLayouts(data.stations)
                completion(.success(layouts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    func getStationDataByName(name: String,
                              minutes: Int?,
                              _ completion: @escaping GetStationDataByNameType) -> NetworkCancellable? {
        let request = GetStationDataByNameRequest(name: name, minutes: minutes)
        return getStationDataByNameUseCase.execute(request) { result in
        switch result {
            case .success(let data):
                let layouts = StationSceneLayouts(data.stationsData)
                completion(.success(layouts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    func getStationDataByCode(code: String,
                              minutes: Int?,
                              _ completion: @escaping GetStationDataByCodeType) -> NetworkCancellable? {
        let request = GetStationDataByCodeRequest(code: code, minutes: minutes)
        return getStationDataByCodeUseCase.execute(request)  { result in
        switch result {
            case .success(let data):
                let layouts = StationSceneLayouts(data.stationsData)
                completion(.success(layouts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    @discardableResult
    func getStationsFilter(filter: String,
                           _ completion: @escaping GetStationsFilterType) -> NetworkCancellable? {
        let request = GetStationsFilterRequest(filter: filter)
        return getStationsFilterUseCase.execute(request)  { result in
        switch result {
            case .success(let data):
                let layouts = StationSceneLayouts(data.stations)
                completion(.success(layouts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getStationTypes() -> [StationType] {
        return StationType.allCases
    }
    
}
