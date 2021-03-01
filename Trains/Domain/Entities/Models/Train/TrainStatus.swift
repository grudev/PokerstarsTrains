//
//  TrainStatus.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

enum TrainStatus: String, Decodable {
    case notRunning = "N"
    case running = "R"
    case other = "T"
}
