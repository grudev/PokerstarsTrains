//
//  GetStationDataByCodeRepository.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

typealias GetStationDataByCodeResultType = (Result<StationDataCollection, Error>) -> Void

protocol GetStationDataByCodeRepository {
    init(_ networkManager: NetworkManager)
    func getStationData(_ request: GetStationDataByCodeRequest,
                        _ completion: @escaping GetStationDataByCodeResultType) -> NetworkCancellable?
}

final class NetworkGetStationDataByCodeRepository: GetStationDataByCodeRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getStationData(_ request: GetStationDataByCodeRequest,
                        _ completion: @escaping GetStationDataByCodeResultType) -> NetworkCancellable? {
        do {
            
            let request = try APIRouter.getStationDataByCode(
                code: request.code,
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
