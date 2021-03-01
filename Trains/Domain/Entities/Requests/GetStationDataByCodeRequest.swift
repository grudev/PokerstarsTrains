//
//  GetStationDataByCodeRequest.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct GetStationDataByCodeRequest {
    
    var code: String
    var minutes: Int?
    
    init(code: String, minutes: Int? = nil) {
        self.code = code
        self.minutes = minutes
    }
    
}
