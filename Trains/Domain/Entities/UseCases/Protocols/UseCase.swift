//
//  UseCase.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import Foundation

protocol UseCase {
    
    associatedtype Response
    associatedtype Request
    
    func execute(_ request: Request?, _ completion: @escaping (_ result: Result<Response, Error>) -> Void) -> NetworkCancellable?
    
}
