//
//  TrainDetailsSceneDataProvider.swift
//  Trains
//
//  Created by Dimitar Grudev on 9.03.21.
//

import UIKit

protocol TrainDetailsSceneDataProviderDelegate: AnyObject { }

final class TrainDetailsSceneDataProvider: NSObject {
    
    // MARK: - Private Properties -
    
    private let cellIdentifier = UITableViewCell.uniqueIdentifier
    private weak var tableView: UITableView!
    private var styles: TrainDetailsTableViewStylable!
    private lazy var tableFooterView = UIView()
    private var data: TrainMovementsCollection?
    
    // MARK: - Delegate -
    
    weak var delegate: TrainDetailsSceneDataProviderDelegate?
    
    // MARK: - Lifecycle -
    
    init(_ tableView: UITableView, _ styles: TrainDetailsTableViewStylable) {
        super.init()
        self.tableView = tableView
        self.styles = styles
        setup()
    }
    
    func load(_ data: TrainMovementsCollection) {
        self.data = data
        tableView.reloadData()
    }
    
}

private extension TrainDetailsSceneDataProvider {
    
    func setup() {
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = K.trainCellHeight
        
        tableView.showsVerticalScrollIndicator = false
        tableView.tableFooterView = tableFooterView
        
    }
    
}

// MARK: - UITableViewDataSource

extension TrainDetailsSceneDataProvider: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        data?.trainMovements.count ?? 0
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier),
              let model = data?.trainMovements[indexPath.row] else {
            return UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        cell.textLabel?.font = styles.textFont
        cell.textLabel?.textColor = styles.textColor
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = "Location Code: \(model.locationCode), \n Destination: \(model.trainDestination), \n Date: \(model.trainDate) \n Origin: \(model.trainOrigin) - Destination: \(model.trainDestination)"
        
        let backgroundColor = indexPath.row % 2 == 0 ? styles.evenCellBackgroundColor : styles.oddCellBackgroundColor
        cell.backgroundColor = backgroundColor
        
        return cell
    }
    
}

// MARK: - Local Constants

extension TrainDetailsSceneDataProvider {
    
    struct K {
        static let trainCellHeight: CGFloat = 500
    }
    
}

// MARK: - Stylable

protocol TrainDetailsTableViewStylable {
    var textFont: UIFont { get }
    var textColor: UIColor { get }
    var evenCellBackgroundColor: UIColor { get }
    var oddCellBackgroundColor: UIColor { get }
}

extension TrainDetailsSceneDataProvider {
    
    class StyleSheet: TrainDetailsTableViewStylable {
        
        var textFont: UIFont
        var textColor: UIColor
        var evenCellBackgroundColor: UIColor
        var oddCellBackgroundColor: UIColor
        
        init(textFont: UIFont,
             textColor: UIColor,
             evenCellBackgroundColor: UIColor,
             oddCellBackgroundColor: UIColor) {
            self.textFont = textFont
            self.textColor = textColor
            self.evenCellBackgroundColor = evenCellBackgroundColor
            self.oddCellBackgroundColor = oddCellBackgroundColor
        }
        
    }
    
}
