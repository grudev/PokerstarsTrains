//
//  GetAllStations.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

final class GetAllStations: UseCase {

    typealias Response = StationsCollection
    typealias Request = Void
    
    private let repository: GetAllStationsRepository
    
    init(_ repository: GetAllStationsRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request?,
                 _ completion: @escaping (_ result: Result<Response, Error>) -> Void) -> NetworkCancellable? {
        repository.getAllStations(completion)
    }
    
}
