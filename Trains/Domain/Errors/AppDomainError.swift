//
//  AppDomainError.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import Foundation

enum AppDomainError: String, Error {
    
    // MARK: - Presentation Errors -
    
    case appWindowFailedToCreate = "fatal.error"
    case failedToDequeueCell
    
    // MARK: - Network Errors -
    
    case failedToResolveBaseUrl = "failed.to.resolve.base.url"
    
    // MARK: - Serialisation Errors -
    
    case failedToDecodeImageData
    case failedToDecodeData
    
}

func fatalError(_ error: AppDomainError) -> Never {
    fatalError("ERROR: \(error.rawValue)")
}
