//
//  TrainPosition.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct TrainPosition: Decodable {
    
    var status: TrainStatus
    var latitude: Double
    var longitude: Double
    var code: String
    var publicMessage: String
    var direction: String
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case status = "TrainStatus"
        case latitude = "TrainLatitude"
        case longitude = "TrainLongitude"
        case code = "TrainCode"
        case publicMessage = "PublicMessage"
        case direction = "Direction"
    }
    
}
