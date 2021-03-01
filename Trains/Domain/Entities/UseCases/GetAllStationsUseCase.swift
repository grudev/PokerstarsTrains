//
//  GetAllStationsUseCase.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

final class GetAllStationsUseCase: UseCase {

    typealias Response = StationsCollection
    typealias Request = GetAllStationsRequest
    
    private let repository: GetAllStationsRepository
    
    init(_ repository: GetAllStationsRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request,
                 _ completion: @escaping (_ result: Result<Response, Error>) -> Void) -> NetworkCancellable? {
        repository.getAllStations(request, completion)
    }
    
}
