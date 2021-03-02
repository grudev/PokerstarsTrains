//
//  GetTrainMovementsUseCase.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

final class GetTrainMovementsUseCase: UseCase {
    
    typealias Response = TrainMovementsCollection
    typealias Request = GetTrainMovementsRequest

    private let repository: GetTrainMovementsRepository

    init(_ repository: GetTrainMovementsRepository) {
        self.repository = repository
    }

    func execute(_ request: Request,
                 _ completion: @escaping (Result<Response, Error>) -> Void) -> NetworkCancellable? {
        repository.getTrainMovements(request, completion)
    }
    
}
