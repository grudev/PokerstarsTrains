//
//  MainSceneLayouts.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import Foundation

final class MainSceneLayouts {
    
    private var cellViewModels = [ItemCellViewModel]()
    
    init(_ parent: ItemCellViewModelParent, _ items: [String]) {
        cellViewModels = items.map { ItemCellViewModel($0, parent) }
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfItems() -> Int {
        cellViewModels.count
    }
    
    func getCellViewModel(for item: Int) -> ItemCellViewModel {
        cellViewModels[item]
    }
    
}
