//
//  GetStationsFilterRepository.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

typealias GetStationsFilterResultType = (Result<StationsFilterCollection, Error>) -> Void

protocol GetStationsFilterRepository {
    init(_ networkManager: NetworkManager)
    func getStationsFiltered(_ request: GetStationsFilterRequest,
                             _ completion: @escaping GetStationsFilterResultType) -> NetworkCancellable?
}

final class NetworkGetStationsFilterRepository: GetStationsFilterRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getStationsFiltered(_ request: GetStationsFilterRequest,
                             _ completion: @escaping GetStationsFilterResultType) -> NetworkCancellable? {
        do {
            
            let request = try APIRouter.getStationsFilter(
                filter: request.filter
            ).asURLRequest()
            
            let cancelable = networkManager.request(request, completion: completion)
            return cancelable
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
}
