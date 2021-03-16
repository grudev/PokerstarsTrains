//
//  TrainSceneLayouts.swift
//  Trains
//
//  Created by Dimitar Grudev on 9.03.21.
//

import Foundation

final class TrainSceneLayouts {
    
    private var cellViewModels = [TrainCellViewModel]()
    
    init(_ items: [TrainPosition]) {
        cellViewModels = items.map { TrainCellViewModel($0) }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        cellViewModels.count
    }
    
    func getCellViewModel(for item: Int) -> TrainCellViewModel {
        cellViewModels[item]
    }
    
}
