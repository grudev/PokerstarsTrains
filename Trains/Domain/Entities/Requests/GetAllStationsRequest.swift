//
//  GetAllStationsRequest.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct GetAllStationsRequest {
    
    var type: StationType?
    
    init(type: StationType? = nil) {
        self.type = type
    }
    
}
