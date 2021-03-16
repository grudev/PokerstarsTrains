//
//  StationData.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct StationData: Decodable {
    
    var serverTime: String
    var trainCode: String
    var stationFullName: String
    var stationCode: String
    var queryTime: String
    var trainDate: String
    var origin: String
    var destination: String
    var originTime: String
    var destinationTime: String
    var status: String
    var lastLocation: String?
    var duein: Int
    var late: Int
    var expArrival: String
    var expDepart: String
    var schArrival: String
    var schDepart: String
    var direction: String
    var trainType: String
    var locationType: String
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case serverTime = "Servertime"
        case trainCode = "Traincode"
        case stationFullName = "Stationfullname"
        case stationCode = "Stationcode"
        case queryTime = "Querytime"
        case trainDate = "Traindate"
        case origin = "Origin"
        case destination = "Destination"
        case originTime = "Origintime"
        case destinationTime = "Destinationtime"
        case status = "Status"
        case lastLocation = "Lastlocation"
        case duein = "Duein"
        case late = "Late"
        case expArrival = "Exparrival"
        case expDepart = "Expdepart"
        case schArrival = "Scharrival"
        case schDepart = "Schdepart"
        case direction = "Direction"
        case trainType = "Traintype"
        case locationType = "Locationtype"
    }
    
}
