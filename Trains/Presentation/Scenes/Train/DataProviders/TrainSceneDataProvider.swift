//
//  TrainSceneDataProvider.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

protocol TrainSceneDataProviderDelegate: AnyObject {
    func didSelectTrainCell(_ id: String)
}

final class TrainSceneDataProvider: NSObject {
    
    // MARK: - Private Properties -
    
    private let cellIdentifier = TrainCell.uniqueIdentifier
    private weak var tableView: UITableView!
    private lazy var tableFooterView = UIView()
    private var cellStyles: TrainCellStylable!
    private var layouts: TrainSceneLayouts?
    
    // MARK: - Delegate -
    
    weak var delegate: TrainSceneDataProviderDelegate?
    
    // MARK: - Lifecycle -
    
    init(_ tableView: UITableView, _ cellStyles: TrainCellStylable) {
        super.init()
        self.tableView = tableView
        self.cellStyles = cellStyles
        setup()
    }
    
    func load(_ data: TrainSceneLayouts) {
        self.layouts = data
        tableView.reloadData()
    }
    
}

private extension TrainSceneDataProvider {
    
    func setup() {
        
        let cellNib = UINib(nibName: cellIdentifier, bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = K.trainCellHeight
        
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = tableFooterView
        
    }
    
}

// MARK: - UITableViewDelegate

extension TrainSceneDataProvider: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let cellViewModel = layouts?.getCellViewModel(for: indexPath.row) else {
            fatalError(.failedToDequeueCell)
        }
        delegate?.didSelectTrainCell(cellViewModel.id)
        
    }
    
}

// MARK: - UITableViewDataSource

extension TrainSceneDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        
        layouts?.numberOfItems() ?? 0
        
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? TrainCell,
              let cellViewModel = layouts?.getCellViewModel(for: indexPath.row) else {
            fatalError(.failedToDequeueCell)
        }
        cell.config(cellViewModel, cellStyles)
        
        let backgroundColor = indexPath.row % 2 == 0 ? cellStyles.evenCellBackgroundColor : cellStyles.oddCellBackgroundColor
        cell.backgroundColor = backgroundColor
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        layouts?.numberOfSections() ?? 0
    }
    
}

// MARK: - Local Constants

extension TrainSceneDataProvider {
    
    struct K {
        static let trainCellHeight: CGFloat = 50
    }
    
}
