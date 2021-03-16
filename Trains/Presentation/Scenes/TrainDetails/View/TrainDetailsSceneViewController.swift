//
//  TrainDetailsSceneViewController.swift
//  Trains
//
//  Created by Dimitar Grudev on 9.03.21.
//

import UIKit

class TrainDetailsSceneViewController: UIViewController, StoryboardInstantiable {

    // MARK: - Class Methods -
    
    class func create(with viewModel: TrainDetailsSceneViewModelable,
                      styles: TrainDetailsSceneStylable) -> TrainDetailsSceneViewController {
        let vc = TrainDetailsSceneViewController.instantiateViewController()
        vc.viewModel = viewModel
        vc.styles = styles
        return vc
    }
    
    // MARK: - Components -
    
    @IBOutlet weak private var tableView: UITableView!
    
    private lazy var tableDataProvider: TrainDetailsSceneDataProvider = {
        let dataProvider = TrainDetailsSceneDataProvider(tableView, styles.tableViewStyles)
        dataProvider.delegate = self
        return dataProvider
    }()
    
    // MARK: - Properties -
    
    private var viewModel: TrainDetailsSceneViewModelable!
    private var styles: TrainDetailsSceneStylable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestTrainMovements(Date())
        setup()
    }
    
}

// MARK: - TrainSceneDataProviderDelegate

extension TrainDetailsSceneViewController: TrainDetailsSceneDataProviderDelegate { }

private extension TrainDetailsSceneViewController {
    
    func setup() {
        title = viewModel.getTitle()
    }
    
    func requestTrainMovements(_ date: Date) {
        viewModel.getTrainMovements(date: date) { [weak self] (result) in
            switch result {
            case .success(let data):
                self?.tableDataProvider.load(data)
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }

}

// MARK: - Styles -

protocol TrainDetailsSceneStylable {
    var backgroundColor: UIColor { get }
    var tableViewStyles: TrainDetailsSceneDataProvider.StyleSheet { get }
}

extension TrainDetailsSceneViewController {
    
    struct DefaultTrainDetailsSceneStyles: TrainDetailsSceneStylable {
        var backgroundColor: UIColor
        var tableViewStyles: TrainDetailsSceneDataProvider.StyleSheet
    }
    
}
