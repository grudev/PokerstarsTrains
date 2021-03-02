//
//  TrainMovements.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

struct TrainMovements: Decodable {
    
    var trainCode: String
    var trainDate: String
    var locationCode: String
    var locationFullName: String
    var locationOrder: Int
    var locationType: Int
    var trainOrigin: String
    var trainDestination: String
    var scheduledArrival: String
    var scheduledDeparture: String
    var expectedArrival: String
    var expectedDeparture: String
    var arrival: String
    var departure: String
    var autoArrival: Int
    var autoDepart: Int
    var stopType: String
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case trainCode = "TrainCode"
        case trainDate = "TrainDate"
        case locationCode = "LocationCode"
        case locationFullName = "LocationFullName"
        case locationOrder = "LocationOrder"
        case locationType = "LocationType"
        case trainOrigin = "TrainOrigin"
        case trainDestination = "TrainDestination"
        case scheduledArrival = "ScheduledArrival"
        case scheduledDeparture = "ScheduledDeparture"
        case expectedArrival = "ExpectedArrival"
        case expectedDeparture = "ExpectedDeparture"
        case arrival = "Arrival"
        case departure = "Departure"
        case autoArrival = "AutoArrival"
        case autoDepart = "AutoDepart"
        case stopType = "StopType"
    }
    
}
