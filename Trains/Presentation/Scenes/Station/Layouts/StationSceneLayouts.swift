//
//  StationSceneLayouts.swift
//  Trains
//
//  Created by Dimitar Grudev on 16.03.21.
//

import UIKit

final class StationSceneLayouts {
    
    var isEmpty: Bool {
        return cellViewModels?.isEmpty ?? true
    }
    
    var numberOfItems: Int { cellViewModels?.count ?? 0 }
    
    private var cellViewModels: [StationCellViewModel]?
    
    init(_ items: [Station]?) {
        cellViewModels = items?.map { StationCellViewModel($0) }
    }
    
    init(_ items: [StationData]?) {
        cellViewModels = items?.map { StationCellViewModel($0) }
    }
    
    init(_ items: [StationFilter]?) {
        cellViewModels = items?.map { StationCellViewModel($0) }
    }
    
    func getCellViewModel(for item: Int) -> StationCellViewModel? {
        cellViewModels?[item]
    }
    
}
