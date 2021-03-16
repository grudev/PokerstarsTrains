//
//  TrainSceneViewController.swift
//  Trains
//
//  Created by Dimitar Grudev on 4.03.21.
//

import UIKit

class TrainSceneViewController: UIViewController, StoryboardInstantiable {

    // MARK: - Class Methods -
    
    class func create(with viewModel: TrainSceneViewModelable,
                      styles: TrainSceneStylable) -> TrainSceneViewController {
        let vc = TrainSceneViewController.instantiateViewController()
        vc.viewModel = viewModel
        vc.styles = styles
        return vc
    }
    
    // MARK: - Components -
    
    @IBOutlet weak private var trainSegmentTitleLabel: UILabel!
    @IBOutlet weak private var trainSegmentComponent: UISegmentedControl!
    @IBOutlet weak private var tableView: UITableView!
    
    private lazy var tableDataProvider: TrainSceneDataProvider = {
        let dataProvider = TrainSceneDataProvider(tableView, styles.cellStyles)
        dataProvider.delegate = self
        return dataProvider
    }()
    
    // MARK: - Properties -
    
    private var viewModel: TrainSceneViewModelable!
    private var styles: TrainSceneStylable!
    
    private var selectedTrainTypeIndex = 0
    private var selectedTrainType: TrainType { TrainType.allCases[selectedTrainTypeIndex] }
    
    // MARK: - ViewController Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestCurrentTrain(for: selectedTrainType)
        setup()
    }
    
}

private extension TrainSceneViewController {
    
    func setup() {
        title = viewModel.getTitle()
        trainSegmentTitleLabel.text = viewModel.getSegmentTitleLabel()
        trainSegmentTitleLabel.font = styles.trainSegmentTitleFont
        trainSegmentTitleLabel.textColor = styles.trainSegmentTitleColor
        setupSegmentComponent()
    }
    
    func setupSegmentComponent() {
        trainSegmentComponent.removeAllSegments()
        trainSegmentComponent.selectedSegmentTintColor = styles.selectedSegmentTintColor
        for (index, type) in viewModel.getTrainTypes().enumerated() {
            trainSegmentComponent.insertSegment(withTitle: type.title,
                                                at: index, animated: true)
        }
        let normalAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: styles.segmentTitleFont,
            NSAttributedString.Key.foregroundColor: styles.normalSegmentTitleColor
        ]
        trainSegmentComponent.setTitleTextAttributes(normalAttributes, for: .normal)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: styles.segmentTitleFont,
            NSAttributedString.Key.foregroundColor: styles.selectedSegmentTitleColor
        ]
        trainSegmentComponent.setTitleTextAttributes(selectedAttributes, for: .selected)
        trainSegmentComponent.selectedSegmentIndex = selectedTrainTypeIndex
        
        trainSegmentComponent.addTarget(self,
                                        action: #selector(onTrainSegmentComponenDidChange),
                                        for: .valueChanged)
    }
    
    func requestCurrentTrain(for type: TrainType?) {
        viewModel.getCurrentTrains(type: type) { [weak self] result in
            switch result {
            case .success(let layout):
                self?.tableDataProvider.load(layout)
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    @objc
    func onTrainSegmentComponenDidChange() {
        selectedTrainTypeIndex = trainSegmentComponent.selectedSegmentIndex
        requestCurrentTrain(for: selectedTrainType)
    }
    
}

extension TrainSceneViewController: TrainSceneDataProviderDelegate {
    
    func didSelectTrainCell(_ id: String) {
        viewModel.showTrainDetails(id)
    }
    
}

// MARK: - Styles -

protocol TrainSceneStylable {
    var backgroundColor: UIColor { get }
    var trainSegmentTitleFont: UIFont { get }
    var trainSegmentTitleColor: UIColor { get }
    var selectedSegmentTintColor: UIColor { get }
    var segmentTitleFont: UIFont { get }
    var normalSegmentTitleColor: UIColor { get }
    var selectedSegmentTitleColor: UIColor { get }
    var cellStyles: TrainCell.StyleSheet { get }
}

extension TrainSceneViewController {
    
    struct DefaultTrainSceneStyles: TrainSceneStylable {
        var backgroundColor: UIColor
        var trainSegmentTitleFont: UIFont
        var trainSegmentTitleColor: UIColor
        var selectedSegmentTintColor: UIColor
        var segmentTitleFont: UIFont
        var normalSegmentTitleColor: UIColor
        var selectedSegmentTitleColor: UIColor
        var cellStyles: TrainCell.StyleSheet
    }
    
}
