//
//  StationDataCollection.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct StationDataCollection: Decodable {
    
    var stationsData: [StationData]?
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case stationsData = "objStationData"
    }
    
}
