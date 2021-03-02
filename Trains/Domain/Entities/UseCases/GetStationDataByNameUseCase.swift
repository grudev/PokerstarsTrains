//
//  GetStationDataByNameUseCase.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

final class GetStationDataByNameUseCase: UseCase {
    
    typealias Response = StationDataCollection
    typealias Request = GetStationDataByNameRequest
    
    private let repository: GetStationDataByNameRepository
    
    init(_ repository: GetStationDataByNameRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request,
                 _ completion: @escaping (Result<Response, Error>) -> Void) -> NetworkCancellable? {
        repository.getStationData(request, completion)
    }
    
}
