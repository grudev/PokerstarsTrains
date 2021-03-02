//
//  StationsFilterCollection.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

struct StationsFilterCollection: Decodable {
    
    var stations: [StationFilter]
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case stations = "objStationFilter"
    }
    
}
