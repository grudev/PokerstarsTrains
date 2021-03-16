//
//  StationTableViewDataProvider.swift
//  Trains
//
//  Created by Dimitar Grudev on 16.03.21.
//

import UIKit

final class StationTableViewDataProvider: NSObject {
    
    // MARK: - Private Properties -
    
    private let cellIdentifier = StationCell.uniqueIdentifier
    private weak var tableView: UITableView!
    private lazy var tableFooterView = UIView()
    private var cellStyles: StationCellStylable!
    private var layouts: StationSceneLayouts?
    
    // MARK: - Lifecycle -
    
    init(_ tableView: UITableView, _ cellStyles: StationCellStylable) {
        super.init()
        self.tableView = tableView
        self.cellStyles = cellStyles
        setup()
    }
    
    func load(_ layouts: StationSceneLayouts) {
        self.layouts = layouts
        tableView.reloadData()
    }
    
}

private extension StationTableViewDataProvider {
    
    func setup() {
        
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = K.cellHeight
        
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = tableFooterView
        
    }
    
}

// MARK: - UITableViewDelegate

extension StationTableViewDataProvider: UITableViewDelegate {

}

// MARK: - UITableViewDelegate

extension StationTableViewDataProvider: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        layouts?.numberOfItems ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? StationCell,
              let cellViewModel = layouts?.getCellViewModel(for: indexPath.row) else {
            fatalError(.failedToDequeueCell)
        }
        cell.config(cellViewModel, cellStyles)
        
        let backgroundColor = indexPath.row % 2 == 0 ? cellStyles.evenCellBackgroundColor : cellStyles.oddCellBackgroundColor
        cell.backgroundColor = backgroundColor
        
        return cell
    }

}

// MARK: - Local Constants

extension StationTableViewDataProvider {
    struct K {
        static let cellHeight: CGFloat = 50
    }
}
