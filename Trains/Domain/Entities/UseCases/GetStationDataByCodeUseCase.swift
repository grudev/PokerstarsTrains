//
//  GetStationDataByCodeUseCase.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

final class GetStationDataByCodeUseCase: UseCase {
    
    typealias Response = StationDataCollection
    typealias Request = GetStationDataByCodeRequest
    
    private let repository: GetStationDataByCodeRepository
    
    init(_ repository: GetStationDataByCodeRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request,
                 _ completion: @escaping (Result<Response, Error>) -> Void) -> NetworkCancellable? {
        repository.getStationData(request, completion)
    }
    
}
