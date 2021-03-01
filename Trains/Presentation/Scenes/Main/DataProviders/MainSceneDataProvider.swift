//
//  MainSceneDataProvider.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

protocol MainSceneDataProviderDelegate: AnyObject {
    func didSelectItem(_ id: String)
}

final class MainSceneDataProvider: NSObject {
    
    // MARK: - Private Properties -
    
    private let cellIdentifier = ItemCell.uniqueIdentifier
    private weak var collectionView: UICollectionView!
    private var cellStyles: ItemCellStylable!
    private var layouts: MainSceneLayouts?
    
    // MARK: - Delegate -
    
    weak var delegate: MainSceneDataProviderDelegate?
    
    // MARK: - Lifecycle -
    
    init(_ collectionView: UICollectionView, _ cellStyles: ItemCellStylable) {
        super.init()
        self.collectionView = collectionView
        self.cellStyles = cellStyles
        setup()
    }
    
    func load(_ data: MainSceneLayouts) {
        self.layouts = data
        collectionView.reloadData()
    }
    
}

private extension MainSceneDataProvider {
    
    func setup() {
        collectionView.register(ItemCell.self,
                                forCellWithReuseIdentifier: cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
    }
    
}

extension MainSceneDataProvider: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        guard let cellViewModel = layouts?.getCellViewModel(for: indexPath.item) else { return }
        delegate?.didSelectItem(cellViewModel.id)
    }
    
}

extension MainSceneDataProvider: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        layouts?.numberOfSections() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        layouts?.numberOfItems() ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? ItemCell,
              let cellViewModel = layouts?.getCellViewModel(for: indexPath.item) else {
            fatalError(.failedToDequeueCell)
        }
        cell.config(cellViewModel, cellStyles)
        return cell
    }
    
}
