//
//  StationFilter.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

struct StationFilter: Decodable {
    
    var descriptionSp: String
    var description: String
    var code: String
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case descriptionSp = "StationDesc_sp"
        case description = "StationDesc"
        case code = "StationCode"
    }
    
}
