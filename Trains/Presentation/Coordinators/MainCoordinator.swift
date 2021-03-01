//
//  MainCoordinator.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

protocol MainCoordinatorDIContainer {
    
    // MARK: - Main Scene
    
    func makeMainSceneViewModel(_ callbacks: MainSceneViewModelCallbacks) -> MainSceneViewModelable
    func makeMainSceneViewController(_ viewModel: MainSceneViewModelable) -> MainSceneViewController
    
}

final class MainCoordinator: Coordinatable {
    
    // MARK: - Properties
    
    private let window: UIWindow!
    
    var parentCoordinator: Coordinatable?
    var childCoordinators: [Coordinatable]?
    lazy var navigationController = UINavigationController()
    var rootViewController: UIViewController?
    
    // MARK: - DI Container
    
    private let container: MainCoordinatorDIContainer!
    
    // MARK: - Coordinator Lifecycle
    
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
        
        let _itemSelected = { [weak self] (itemId: String) -> Void in
            self?.presentItemDetailScene(itemId)
        }
        
        let callbacks = MainSceneViewModelCallbacks(onItemSelected: _itemSelected)
        let viewModel = container.makeMainSceneViewModel(callbacks)
        let viewController = container.makeMainSceneViewController(viewModel)
        navigationController.pushViewController(viewController, animated: false)
        
    }
    
    func presentItemDetailScene(_ id: String) {
        
    }
    
}
