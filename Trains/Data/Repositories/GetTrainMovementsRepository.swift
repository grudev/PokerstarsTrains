//
//  GetTrainMovementsRepository.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

typealias GetTrainMovementsResultType = (Result<TrainMovementsCollection, Error>) -> Void

protocol GetTrainMovementsRepository {
    init(_ networkManager: NetworkManager)
    func getTrainMovements(_ request: GetTrainMovementsRequest,
                           _ completion: @escaping GetTrainMovementsResultType) -> NetworkCancellable?
}

final class NetworkGetTrainMovementsRepository: GetTrainMovementsRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getTrainMovements(_ request: GetTrainMovementsRequest,
                           _ completion: @escaping GetTrainMovementsResultType) -> NetworkCancellable? {
        do {
            
            let request = try APIRouter.getTrainMovements(request: request).asURLRequest()
            let cancelable = networkManager.request(request, completion: completion)
            return cancelable
            
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
}
