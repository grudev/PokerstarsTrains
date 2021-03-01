//
//  GetCurrentTrainsUseCase.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

final class GetCurrentTrainsUseCase: UseCase {

    typealias Response = CurrentTrainsCollection
    typealias Request = GetCurrentTrainsRequest
    
    private let repository: GetCurrentTrainsRepository
    
    init(_ repository: GetCurrentTrainsRepository) {
        self.repository = repository
    }
    
    func execute(_ request: Request,
                 _ completion: @escaping (_ result: Result<Response, Error>) -> Void) -> NetworkCancellable? {
        repository.getCurrentTrains(request, completion)
    }
    
}
