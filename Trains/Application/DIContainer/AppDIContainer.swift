//
//  AppDIContainer.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

final class AppDIContainer {
    
    // TODO: - Add App Storages, Services, Network Managers etc.
    
    private let networkManager: NetworkManager = DefaultNetworkManager()
    
}

// MARK: - MainCoordinatorDIContainer

extension AppDIContainer: MainCoordinatorDIContainer {
    
    func makeMainSceneViewModel(_ callbacks: MainSceneViewModelCallbacks) -> MainSceneViewModelable {
        MainSceneViewModel(
            callbacks,
            makeGetAllStationsUseCase(),
            makeGetCurrentTrainsUseCase()
        )
    }
    
    func makeMainSceneViewController(_ viewModel: MainSceneViewModelable) -> MainSceneViewController {
        MainSceneViewController(viewModel, AppTheme.makeMainSceneStyles())
    }
    
}

// MARK: - UseCases -

private extension AppDIContainer {
    
    func makeGetAllStationsUseCase() -> GetAllStationsUseCase {
        GetAllStationsUseCase(makeGetAllStationsRepository())
    }
    
    func makeGetCurrentTrainsUseCase() -> GetCurrentTrainsUseCase {
        GetCurrentTrainsUseCase(makeGetCurrentTrainsRepository())
    }

}

// MARK: - Repositories -

private extension AppDIContainer {
    
    func makeGetAllStationsRepository() -> GetAllStationsRepository {
        NetworkGetAllStationsRepository(networkManager)
    }
    
    func makeGetCurrentTrainsRepository() -> GetCurrentTrainsRepository {
        NetworkGetCurrentTrainsRepository(networkManager)
    }
    
}
