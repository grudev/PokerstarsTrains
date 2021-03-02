//
//  GetStationsFilterUseCase.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

final class GetStationsFilterUseCase: UseCase {
    
    typealias Response = StationsFilterCollection
    typealias Request = GetStationsFilterRequest

    private let repository: GetStationsFilterRepository

    init(_ repository: GetStationsFilterRepository) {
        self.repository = repository
    }

    func execute(_ request: Request,
                 _ completion: @escaping (Result<Response, Error>) -> Void) -> NetworkCancellable? {
        repository.getStationsFiltered(request, completion)
    }
    
}
