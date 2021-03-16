//
//  StationType.swift
//  Trains
//
//  Created by Dimitar Grudev on 1.03.21.
//

import Foundation

enum StationType: String, CaseIterable {
    case all = "A"
    case mainline = "M"
    case suburban = "S"
    case dart = "D"// Dublin Area Rapid Transit - DART
    
    var title: String {
        switch self {
        case .all:
            return "lstr_common_station_type_all".localized()
        case .mainline:
            return "lstr_common_station_type_mainline".localized()
        case .suburban:
            return "lstr_common_station_type_suburban".localized()
        case .dart:
            return "lstr_common_station_type_dart".localized()
        }
    }
    
}
