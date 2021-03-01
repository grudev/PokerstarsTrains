//
//  MainSceneViewController.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

class MainSceneViewController: UIViewController {
    
    // MARK: - Components -
    
    private lazy var collectionViewLayout = UICollectionViewFlowLayout()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = styles.backgroundColor
        return collectionView
    }()
    
    private lazy var dataProvider: MainSceneDataProvider = {
        let dataProvider = MainSceneDataProvider(collectionView, styles.cellStyle)
        dataProvider.delegate = self
        return dataProvider
    }()
    
    // MARK: - Properties -
    
    private var viewModel: MainSceneViewModelable!
    private var styles: MainSceneStylable!
    private var dataCancellable: NetworkCancellable?
    
    // MARK: - ViewController Lifecycle -
    
    init(_ viewModel: MainSceneViewModelable,
         _ styles: MainSceneStylable) {
        self.viewModel = viewModel
        self.styles = styles
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        // setup collection view constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func requestStations(for type: StationType?) {
        let request = GetAllStationsRequest(type: type)
        dataCancellable = viewModel.getAllStations(request) { result in
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

