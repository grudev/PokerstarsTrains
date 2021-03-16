//
//  TrainCellViewModel.swift
//  Trains
//
//  Created by Dimitar Grudev on 8.03.21.
//

import UIKit

class TrainCellViewModel {
    
    private(set) var trainPosition: TrainPosition!
    
    var id: String { trainPosition.code }
    
    var status: String {
        "lstr_train_cell_show_status".localized() + ": " + trainPosition.status.localized
    }
    
    var message: String {
        "lstr_train_cell_show_message".localized() + ": " + trainPosition.publicMessage.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    var direction: String {
        "lstr_train_cell_show_direction".localized() + ": " + trainPosition.direction
    }
    
    init(_ trainPosition: TrainPosition) {
        self.trainPosition = trainPosition
    }
    
    func getLocationButtonTitle() -> String {
        "lstr_train_cell_show_location".localized()
    }
    
}
