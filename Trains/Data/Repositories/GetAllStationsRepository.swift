//
//  GetAllStationsRepository.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

typealias GetAllStationsDataType = StationsCollection
typealias GetAllStationsResultType = (Result<GetAllStationsDataType, Error>) -> Void

protocol GetAllStationsRepository {
    init(_ networkManager: NetworkManager)
    func getAllStations(_ completion: @escaping GetAllStationsResultType) -> NetworkCancellable?
}

final class NetworkGetAllStationsRepository: GetAllStationsRepository {
    
    private var networkManager: NetworkManager!
    
    init(_ networkManager: NetworkManager) {
        self.networkManager = networkManager
    }
    
    func getAllStations(_ completion: @escaping GetAllStationsResultType) -> NetworkCancellable? {
        do {
            let request = try APIRouter.getAllStations(type: nil).asURLRequest()
            let cancelable = networkManager.request(request, completion: completion)
            return cancelable
        } catch {
            completion(.failure(error))
            return nil
        }
    }
    
}
