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
    
    var localized: String {
        switch self {
        case .notRunning:
            return "lstr_train_status_not_running".localized()
        case .running:
            return "lstr_train_status_running".localized()
        case .other:
            return "lstr_train_status_other".localized()
        }
    }
    
}
