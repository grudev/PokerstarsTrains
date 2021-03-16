//
//  TrainSceneViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 4.03.21.
//

import UIKit

typealias GetCurrentTrainsType = (_ result: Result<TrainSceneLayouts, Error>) -> Void

struct TrainSceneViewModelCallbacks {
    let showTrainDetails: (_ id: String) -> Void
}

protocol TrainSceneViewModelable {
    
    // MARK: - Public Methods
    
    func getTitle() -> String
    
    func getSegmentTitleLabel() -> String
    
    func getTrainTypes() -> [TrainType]
    
    @discardableResult
    func getCurrentTrains(type: TrainType?,
                          _ completion: @escaping GetCurrentTrainsType) -> NetworkCancellable?
    
    func showTrainDetails(_ id: String)
    
}

class TrainSceneViewModel: TrainSceneViewModelable {
    
    // MARK: - Private Properties -
    
    private let callbacks: TrainSceneViewModelCallbacks!
    
    private let getCurrentTrainsUseCase: GetCurrentTrainsUseCase!
    
    // MARK: - ViewModel Lifecycle -
    
    init(_ callbacks: TrainSceneViewModelCallbacks,
         _ getCurrentTrainsUseCase: GetCurrentTrainsUseCase) {
        self.callbacks = callbacks
        self.getCurrentTrainsUseCase = getCurrentTrainsUseCase
    }
    
    // MARK: - Public API -
    
    func getTitle() -> String {
        "lstr_main_scene_search_for_train".localized()
    }
    
    func getSegmentTitleLabel() -> String {
        "lstr_train_scene_train_type_label".localized()
    }
    
    func getTrainTypes() -> [TrainType] {
        return TrainType.allCases
    }
    
    @discardableResult
    func getCurrentTrains(type: TrainType?,
                          _ completion: @escaping GetCurrentTrainsType) -> NetworkCancellable? {
        
        let request = GetCurrentTrainsRequest(type: type)
        
        return getCurrentTrainsUseCase.execute(request) { (result) in
            switch result {
            case .success(let data):
                let layouts = TrainSceneLayouts(data.trains)
                completion(.success(layouts))
            case .failure(let error):
                completion(.failure(error))
            }
        }
        
    }
    
    func showTrainDetails(_ id: String) {
        callbacks.showTrainDetails(id)
    }
    
}
