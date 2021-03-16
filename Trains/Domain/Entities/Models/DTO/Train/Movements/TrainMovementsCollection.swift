//
//  TrainMovementsCollection.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

struct TrainMovementsCollection: Decodable {
    
    var trainMovements: [TrainMovements]
    
    // MARK: - Custom Coding Keys -
    
    enum CodingKeys: String, CodingKey {
        case trainMovements = "objTrainMovements"
    }
    
}
