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
    
    // MARK: - Main Scene -
    
    func makeMainSceneViewModel(_ callbacks: MainSceneViewModelCallbacks) -> MainSceneViewModelable {
        MainSceneViewModel(callbacks)
    }
    
    func makeMainSceneViewController(_ viewModel: MainSceneViewModelable) -> MainSceneViewController {
        MainSceneViewController.create(with: viewModel,
                                       styles: AppTheme.makeMainSceneStyles())
    }
    
    // MARK: - Search Station Scene -
    
    func makeStationSceneViewModel(_ callbacks: StationSceneViewModelCallbacks) -> StationSceneViewModelable {
        StationSceneViewModel(callbacks,
                              makeGetAllStationsUseCase(),
                              makeGetStationDataByNameUseCase(),
                              makeGetStationDataByCodeUseCase(),
                              makeGetStationsFilterUseCase())
    }
    
    func makeStationSceneViewController(_ viewModel: StationSceneViewModelable) -> StationSceneViewController {
        StationSceneViewController.create(with: viewModel,
                                          styles: AppTheme.makeStationSceneStyles())
    }
    
    // MARK: - Search Train Scene -
    
    func makeTrainSceneViewModel(_ callbacks: TrainSceneViewModelCallbacks) -> TrainSceneViewModelable {
        TrainSceneViewModel(callbacks, makeGetCurrentTrainsUseCase())
    }
    
    func makeTrainSceneViewController(_ viewModel: TrainSceneViewModelable) -> TrainSceneViewController {
        TrainSceneViewController.create(with: viewModel,
                                        styles: AppTheme.makeTrainSceneStyles())
    }
    
    // MARK: - Train Details Scene -
    
    func makeTrainDetailsSceneViewModel(_ id: String,
                                        _ callbacks: TrainDetailsSceneViewModelCallbacks) -> TrainDetailsSceneViewModelable {
        TrainDetailsSceneViewModel(id, callbacks, makeGetTrainMovementsUseCase())
    }
    
    func makeTrainDetailsSceneViewController(_ viewModel: TrainDetailsSceneViewModelable) -> TrainDetailsSceneViewController {
        TrainDetailsSceneViewController.create(with: viewModel,
                                               styles: AppTheme.makeTrainDetailsSceneStyles())
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
    
    func makeGetStationDataByNameUseCase() -> GetStationDataByNameUseCase {
        GetStationDataByNameUseCase(makeGetStationDataByNameRepository())
    }
    
    func makeGetStationDataByCodeUseCase() -> GetStationDataByCodeUseCase {
        GetStationDataByCodeUseCase(makeGetStationDataByCodeRepository())
    }
    
    func makeGetStationsFilterUseCase() -> GetStationsFilterUseCase {
        GetStationsFilterUseCase(makeGetStationsFilterRepository())
    }
    
    func makeGetTrainMovementsUseCase() -> GetTrainMovementsUseCase {
        GetTrainMovementsUseCase(makeGetTrainMovementsRepository())
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
    
    func makeGetStationDataByNameRepository() -> GetStationDataByNameRepository {
        NetworkGetStationDataByNameRepository(networkManager)
    }
    
    func makeGetStationDataByCodeRepository() -> GetStationDataByCodeRepository {
        NetworkGetStationDataByCodeRepository(networkManager)
    }
    
    func makeGetStationsFilterRepository() -> GetStationsFilterRepository {
        NetworkGetStationsFilterRepository(networkManager)
    }
    
    func makeGetTrainMovementsRepository() -> GetTrainMovementsRepository {
        NetworkGetTrainMovementsRepository(networkManager)
    }
    
}
