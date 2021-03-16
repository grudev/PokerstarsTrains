//
//  SelectStationCellType.swift
//  Trains
//
//  Created by Dimitar Grudev on 4.03.21.
//

import UIKit

enum SelectStationCellType {
    
    case startStation
    case endStation
    
    var icon: UIImage? {
        switch self {
        case .startStation:
            return UIImage(systemName: "tram.fill")?.withTintColor(.green)
        case .endStation:
            return UIImage(systemName: "tram.fill")?.withTintColor(.red)
        }
    }
    
    var title: String {
        switch self {
        case .startStation:
            return "lstr_start_station".localized()
        case .endStation:
            return "lstr_end_station".localized()
        }
    }
    
}
