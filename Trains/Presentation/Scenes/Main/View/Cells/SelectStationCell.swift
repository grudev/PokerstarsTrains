//
//  SelectStationCell.swift
//  Trains
//
//  Created by Dimitar Grudev on 3.03.21.
//

import UIKit

class SelectStationCell: UITableViewCell {
    
    private var viewModel: SelectStationCellViewModel!
    private var styleSheet: SelectStationCellStylable!
    
    func config(_ viewModel: SelectStationCellViewModel, _ styleSheet: SelectStationCellStylable) {
        self.viewModel = viewModel
        self.styleSheet = styleSheet
    }
    
}

// MARK: - Styles -

protocol SelectStationCellStylable {
    var backgroundColor: UIColor { get }
    var titleFont: UIFont { get }
    var titleColor: UIColor { get }
}

extension SelectStationCell {
    class StyleSheet: SelectStationCellStylable {
        
        var backgroundColor: UIColor
        var titleFont: UIFont
        var titleColor: UIColor
        
        init(backgroundColor: UIColor, titleFont: UIFont, titleColor: UIColor) {
            self.backgroundColor = backgroundColor
            self.titleFont = titleFont
            self.titleColor = titleColor
        }
        
    }
}
