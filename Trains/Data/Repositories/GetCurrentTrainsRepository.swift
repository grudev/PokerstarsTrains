//
//  GetCurrentTrainsRepository.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

typealias GetCurrentTrainsResultType = (Result<CurrentTrainsCollection, Error>) -> Void

protocol GetCurrentTrainsRepository {
    init(_ networkManager: NetworkManager)
    func getCurrentTrains(_ request: GetCurrentTrainsRequest,
                          _ completion: @escaping GetCurrentTrainsResultType) -> NetworkCancellable?
}

final class NetworkGetCurrentTrainsRepository: GetCurrentTrainsRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getCurrentTrains(_ request: GetCurrentTrainsRequest,
                          _ completion: @escaping GetCurrentTrainsResultType) -> NetworkCancellable? {
        do {
            let request = try APIRouter.getCurrentTrains(request: request).asURLRequest()
            let cancelable = networkManager.request(request, completion: completion)
            return cancelable
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
}
