//
//  CurrentTrainsCollection.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

struct CurrentTrainsCollection: Decodable {
    
    var trains: [TrainPosition]
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case trains = "objTrainPositions"
    }
    
}
