//
//  GetStationDataByNameRepository.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

typealias GetStationDataByNameResultType = (Result<StationDataCollection, Error>) -> Void

protocol GetStationDataByNameRepository {
    init(_ networkManager: NetworkManager)
    func getStationData(_ request: GetStationDataByNameRequest,
                        _ completion: @escaping GetStationDataByNameResultType) -> NetworkCancellable?
}

final class NetworkGetStationDataByNameRepository: GetStationDataByNameRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getStationData(_ request: GetStationDataByNameRequest,
                          _ completion: @escaping GetStationDataByNameResultType) -> NetworkCancellable? {
        do {
            
            let request = try APIRouter.getStationDataByName(
                name: request.name,
                minutes: request.minutes
            ).asURLRequest()
            
            let cancelable = networkManager.request(request, completion: completion)
            return cancelable
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
}
