//
//  StationsCollection.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct StationsCollection: Codable {
    
    var stations: [Station]
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case stations = "objStation"
    }
    
}
