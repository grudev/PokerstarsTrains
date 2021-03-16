//
//  TrainDetailsCell.swift
//  Trains
//
//  Created by Dimitar Grudev on 9.03.21.
//

import UIKit

class TrainDetailsCell: UITableViewCell {
    
    private var viewModel: TrainDetailsViewModel!
    private var styleSheet: TrainDetailsCellStylable!
    
    func config(_ viewModel: TrainDetailsViewModel, _ styleSheet: TrainDetailsCellStylable) {
        self.viewModel = viewModel
        self.styleSheet = styleSheet
        setup()
    }
    
}

private extension TrainDetailsCell {
    
    func setup() {
        
    }
    
}


// MARK: - Styles -

protocol TrainDetailsCellStylable {
    var backgroundColor: UIColor { get }
}

extension TrainDetailsCell {
    
    class StyleSheet: TrainDetailsCellStylable {
        
        var backgroundColor: UIColor
        
        init(backgroundColor: UIColor) {
            self.backgroundColor = backgroundColor
        }
        
    }
    
}
