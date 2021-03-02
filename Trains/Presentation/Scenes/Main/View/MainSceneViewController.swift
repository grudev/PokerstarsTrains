//
//  MainSceneViewController.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit
import MapKit

class MainSceneViewController: UIViewController, StoryboardInstantiable {
    
    // MARK: - Class Methods -
    
    class func create(with viewModel: MainSceneViewModelable,
                      styles: MainSceneStylable) -> MainSceneViewController {
        let vc = MainSceneViewController.instantiateViewController()
        vc.viewModel = viewModel
        vc.styles = styles
        return vc
    }
    
    // MARK: - Components -
    
    @IBOutlet weak private var mapView: MKMapView!
    
    // MARK: - Properties -
    
    private var viewModel: MainSceneViewModelable!
    private var styles: MainSceneStylable!
    
    // MARK: - ViewController Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        requestStations(for: nil)
    }
    
}

// MARK: - Private Logic -

private extension MainSceneViewController {
    
    func setup() {
        view.backgroundColor = styles.backgroundColor
        
    }
    
    func requestStations(for type: StationType?) {
        viewModel.getAllStations(type: type) { result in
            switch result {
            case .success(let data):
                print("SUCCESS \(data)")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    func requestCurrentTraint(for type: TrainType?) {
        viewModel.getCurrentTrains(type: type) { result in
            switch result {
            case .success(let data):
                print("SUCCESS \(data)")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    func requestStationDataByName(_ name: String, minutes: Int?) {
        viewModel.getStationDataByName(name: name, minutes: minutes) { (result) in
            switch result {
            case .success(let data):
                print("SUCCESS \(data)")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    func requestStationDataByCode(_ code: String, minutes: Int?) {
        viewModel.getStationDataByCode(code: code, minutes: minutes) { (result) in
            switch result {
            case .success(let data):
                print("SUCCESS \(data)")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    func requestStationsFilter(_ filter: String) {
        viewModel.getStationsFilter(filter: filter) { (result) in
            switch result {
            case .success(let data):
                print("SUCCESS \(data)")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
    func requestTrainMovements(_ id: String, _ date: Date) {
        viewModel.getTrainMovements(id: id, date: date) { (result) in
            switch result {
            case .success(let data):
                print("SUCCESS \(data)")
            case .failure(let error):
                print("ERROR \(error)")
            }
        }
    }
    
}

// MARK: - MainSceneDataProviderDelegate -

extension MainSceneViewController: MainSceneDataProviderDelegate {
    
    func didSelectItem(_ id: String) {
        viewModel.didSelectItem(id)
    }
    
}

// MARK: - Styles -

protocol MainSceneStylable {
    var backgroundColor: UIColor { get }
    var cellStyle: ItemCell.StyleSheet { get }
}

extension MainSceneViewController {
    
    struct DefaultMainSceneStyles: MainSceneStylable {
        var backgroundColor: UIColor
        var cellStyle: ItemCell.StyleSheet
    }
    
}

