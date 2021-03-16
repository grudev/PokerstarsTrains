//
//  StationCellViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 16.03.21.
//

import Foundation

class StationCellViewModel {
    
    enum StationCellType {
        case `default`
        case data
        case filter
    }
    
    var type: StationCellType
    
    private var station: Station?
    private var stationData: StationData?
    private var stationFilter: StationFilter?
    
    var description: String {
        if let station = station {
            return station.description
        } else if let data = stationData {
            return "Code: \(data.stationCode), Full Name: \(data.stationFullName)"
        } else if let filter = stationFilter {
            return filter.description
        }
        return ""
    }
    
    init(_ station: Station) {
        self.station = station
        type = .default
    }
    
    init(_ stationData: StationData) {
        self.stationData = stationData
        type = .data
    }
    
    init(_ stationFilter: StationFilter) {
        self.stationFilter = stationFilter
        type = .filter
    }
    
}
