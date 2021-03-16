//
//  StationCell.swift
//  Trains
//
//  Created by Dimitar Grudev on 16.03.21.
//

import UIKit

class StationCell: UITableViewCell {
    
    @IBOutlet weak private var textView: UITextView!
    
    private var viewModel: StationCellViewModel!
    private var styleSheet: StationCellStylable!
    
    func config(_ viewModel: StationCellViewModel, _ styleSheet: StationCellStylable) {
        self.viewModel = viewModel
        self.styleSheet = styleSheet
        setup()
    }
    
}

private extension StationCell {
    
    func setup() {
        setupStyles()
        textView.text = viewModel.description
    }
    
    func setupStyles() {
        textView.font = styleSheet.textFont
        textView.textColor = styleSheet.textColor
        textView.backgroundColor = .clear
    }
    
}

// MARK: - Styles -

protocol StationCellStylable {
    var evenCellBackgroundColor: UIColor { get }
    var oddCellBackgroundColor: UIColor { get }
    var textFont: UIFont { get }
    var textColor: UIColor { get }
}

extension StationCell {
    class StyleSheet: StationCellStylable {
        
        var evenCellBackgroundColor: UIColor
        var oddCellBackgroundColor: UIColor
        var textFont: UIFont
        var textColor: UIColor
        
        init(evenCellBackgroundColor: UIColor,
             oddCellBackgroundColor: UIColor,
             textFont: UIFont,
             textColor: UIColor) {
            
            self.evenCellBackgroundColor = evenCellBackgroundColor
            self.oddCellBackgroundColor = oddCellBackgroundColor
            self.textFont = textFont
            self.textColor = textColor
            
        }
        
    }
}
