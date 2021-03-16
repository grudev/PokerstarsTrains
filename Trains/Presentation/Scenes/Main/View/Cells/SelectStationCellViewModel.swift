//
//  SelectStationCellViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 3.03.21.
//

import UIKit

protocol SelectStationCellViewModelParent: AnyObject { }

class SelectStationCellViewModel {
    
    private weak var parent: SelectStationCellViewModelParent?
    
    private var type: SelectStationCellType
    
    init(_ type: SelectStationCellType, _ parent: SelectStationCellViewModelParent) {
        self.type = type
        self.parent = parent
    }
    
}

