//
//  ItemCell.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    private var viewModel: ItemCellViewModel!
    private var styleSheet: ItemCellStylable!
    
    func config(_ viewModel: ItemCellViewModel, _ styleSheet: ItemCellStylable) {
        self.viewModel = viewModel
        self.styleSheet = styleSheet
    }
    
}

// MARK: - Styles -

protocol ItemCellStylable {
    var backgroundColor: UIColor { get }
    var titleFont: UIFont { get }
    var titleColor: UIColor { get }
}

extension ItemCell {
    class StyleSheet: ItemCellStylable {
        
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
