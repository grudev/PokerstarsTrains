//
//  TrainDetailsSceneViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 9.03.21.
//

import UIKit

typealias GetTrainsMovementsType = (Result<TrainMovementsCollection, Error>) -> Void

struct TrainDetailsSceneViewModelCallbacks { }

protocol TrainDetailsSceneViewModelable {
    
    func getTitle() -> String
    
    @discardableResult
    func getTrainMovements(date: Date,
                           _ completion: @escaping GetTrainsMovementsType) -> NetworkCancellable?
    
}

class TrainDetailsSceneViewModel: TrainDetailsSceneViewModelable {
    
    // MARK: - Private Properties -
    
    private var id: String!
    private let callbacks: TrainDetailsSceneViewModelCallbacks!
    private let getTrainMovementsUseCase: GetTrainMovementsUseCase!
    
    // MARK: - ViewModel Lifecycle -
    
    init(_ id: String,
         _ callbacks: TrainDetailsSceneViewModelCallbacks,
         _ getTrainMovementsUseCase: GetTrainMovementsUseCase) {
        self.id = id
        self.callbacks = callbacks
        self.getTrainMovementsUseCase = getTrainMovementsUseCase
    }
    
    func getTrainMovements(date: Date,
                           _ completion: @escaping GetTrainsMovementsType) -> NetworkCancellable? {
        let _date = DateFormatter.trainMovementsDateFormatter.string(from: date)
        let request = GetTrainMovementsRequest(id: id, date: _date)
        return getTrainMovementsUseCase.execute(request, completion)
    }
    
    func getTitle() -> String {
        return "lstr_train_details_title".localized()
    }
    
}
