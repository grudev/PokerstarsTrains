//
//  GetCurrentTrainsRequest.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct GetCurrentTrainsRequest {
    
    var type: TrainType?
    
    init(type: TrainType? = nil) {
        self.type = type
    }
    
}
