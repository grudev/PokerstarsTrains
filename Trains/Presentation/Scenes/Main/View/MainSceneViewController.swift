//
//  MainSceneViewController.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

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
    
    @IBOutlet weak private var searchStationButton: UIButton!
    @IBOutlet weak private var searchTrainButton: UIButton!
    
    // MARK: - Properties -
    
    private var viewModel: MainSceneViewModelable!
    private var styles: MainSceneStylable!
    
    // MARK: - ViewController Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
}

// MARK: - IBActions

extension MainSceneViewController {
    
    @IBAction func onSearchStationButtonPressed() {
        viewModel.searchStationDidPress()
    }
    
    @IBAction func onSearchTrainButtonPressed() {
        viewModel.searchTrainDidPress()
    }
    
}

// MARK: - Private Logic -

private extension MainSceneViewController {
    
    func setup() {
        
        title = viewModel.getSceneTitle()
        view.backgroundColor = styles.backgroundColor
        
        searchStationButton.setTitle(
            viewModel.getSearchStationButtonTitle(),
            for: .normal
        )
        setupButtonStyle(&searchStationButton)
        
        searchTrainButton.setTitle(
            viewModel.getSearchTrainButtonTitle(),
            for: .normal
        )
        setupButtonStyle(&searchTrainButton)
        
    }
    
    func setupButtonStyle(_ button: inout UIButton) {
        button.backgroundColor = styles.buttonBackgroundColor
        button.setTitleColor(styles.buttonTitleColor, for: .normal)
        button.setTitleColor(styles.buttonTitleColor, for: .highlighted)
        button.layer.cornerRadius = styles.buttonCornerRadius
    }
    
}

// MARK: - Styles -

protocol MainSceneStylable {
    var backgroundColor: UIColor { get }
    var buttonBackgroundColor: UIColor { get }
    var buttonTitleColor: UIColor { get }
    var buttonCornerRadius: CGFloat { get }
}

extension MainSceneViewController {
    
    struct DefaultMainSceneStyles: MainSceneStylable {
        var backgroundColor: UIColor
        var buttonBackgroundColor: UIColor
        var buttonTitleColor: UIColor
        var buttonCornerRadius: CGFloat
    }
    
}

