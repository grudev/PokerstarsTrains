//
//  ItemCellViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

protocol ItemCellViewModelParent: AnyObject { }

class ItemCellViewModel {
    
    private weak var parent: ItemCellViewModelParent?
    
    var id: String = "id"
    
    init(_ item: String, _ parent: ItemCellViewModelParent) {
        self.parent = parent
    }
    
}
