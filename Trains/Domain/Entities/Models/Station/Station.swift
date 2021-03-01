//
//  Station.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct Station: Decodable {
    
    var id: Int
    var description: String
    var alias: String?
    var latitude: Double
    var longitude: Double
    var code: String
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case id = "StationId"
        case description = "StationDesc"
        case alias = "StationAlias"
        case latitude = "StationLatitude"
        case longitude = "StationLongitude"
        case code = "StationCode"
    }
    
}
