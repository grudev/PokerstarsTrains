//
//  GetStationDataByNameRequest.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct GetStationDataByNameRequest {
    
    var name: String
    var minutes: Int?
    
    init(name: String, minutes: Int? = nil) {
        self.name = name
        self.minutes = minutes
    }
    
}
