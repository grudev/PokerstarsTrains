//
//  MainCoordinator.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

protocol MainCoordinatorDIContainer {
    
    // MARK: - Main Scene -
    
    func makeMainSceneViewModel(_ callbacks: MainSceneViewModelCallbacks) -> MainSceneViewModelable
    func makeMainSceneViewController(_ viewModel: MainSceneViewModelable) -> MainSceneViewController
    
    // MARK: - Search Station Scene -
    
    func makeStationSceneViewModel(_ callbacks: StationSceneViewModelCallbacks) -> StationSceneViewModelable
    func makeStationSceneViewController(_ viewModel: StationSceneViewModelable) -> StationSceneViewController
    
    // MARK: - Search Train Scene -
    
    func makeTrainSceneViewModel(_ callbacks: TrainSceneViewModelCallbacks) -> TrainSceneViewModelable
    func makeTrainSceneViewController(_ viewModel: TrainSceneViewModelable) -> TrainSceneViewController
    
    // MARK: - Train Details Scene -
    
    func makeTrainDetailsSceneViewModel(_ id: String,
                                        _ callbacks: TrainDetailsSceneViewModelCallbacks) -> TrainDetailsSceneViewModelable
    func makeTrainDetailsSceneViewController(_ viewModel: TrainDetailsSceneViewModelable) -> TrainDetailsSceneViewController
    
}

final class MainCoordinator: Coordinatable {
    
    // MARK: - Properties -
    
    private let window: UIWindow!
    
    var parentCoordinator: Coordinatable?
    var childCoordinators: [Coordinatable]?
    lazy var navigationController = UINavigationController()
    var rootViewController: UIViewController?
    
    // MARK: - DI Container -
    
    private let container: MainCoordinatorDIContainer!
    
    // MARK: - Coordinator Lifecycle -
    
    init(window: UIWindow?, _ container: MainCoordinatorDIContainer) {
        self.window = window
        self.container = container
        
        navigationController.view.backgroundColor = AppTheme.Colors.white
        self.window.rootViewController = navigationController
        self.window.makeKeyAndVisible()
    }
    
    func start() {
        presentMainScene()
    }
    
}

private extension MainCoordinator {
    
    func presentMainScene() {
        
        let _searchStationDidPress = { [weak self] () -> Void in
            self?.presentSearchStationScene()
        }
        
        let _searchTrainDidPress = { [weak self] () -> Void in
            self?.presentSearchTrainScene()
        }
        
        let callbacks = MainSceneViewModelCallbacks(
            searchStationDidPress: _searchStationDidPress,
            searchTrainDidPress: _searchTrainDidPress
        )
        
        let viewModel = container.makeMainSceneViewModel(callbacks)
        let viewController = container.makeMainSceneViewController(viewModel)
        navigationController.pushViewController(viewController, animated: false)
        
    }
    
    func presentSearchStationScene() {
        let callbacks = StationSceneViewModelCallbacks()
        let viewModel = container.makeStationSceneViewModel(callbacks)
        let viewController = container.makeStationSceneViewController(viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentSearchTrainScene() {
        
        let _showTrainDetails = { [weak self] (id: String) -> Void in
            self?.presentTrainDetailsScene(id)
        }
        
        let callbacks = TrainSceneViewModelCallbacks(showTrainDetails: _showTrainDetails)
        let viewModel = container.makeTrainSceneViewModel(callbacks)
        let viewController = container.makeTrainSceneViewController(viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func presentTrainDetailsScene(_ id: String) {
        let callbacks = TrainDetailsSceneViewModelCallbacks()
        let viewModel = container.makeTrainDetailsSceneViewModel(id, callbacks)
        let viewController = container.makeTrainDetailsSceneViewController(viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
}
