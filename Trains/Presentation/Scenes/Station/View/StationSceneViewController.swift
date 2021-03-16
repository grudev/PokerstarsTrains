//
//  StationSceneViewController.swift
//  Trains
//
//  Created by Dimitar Grudev on 4.03.21.
//

import UIKit

class StationSceneViewController: UIViewController, StoryboardInstantiable {

    // MARK: - Class Methods -
    
    class func create(with viewModel: StationSceneViewModelable,
                      styles: StationSceneStylable) -> StationSceneViewController {
        let vc = StationSceneViewController.instantiateViewController()
        vc.viewModel = viewModel
        vc.styles = styles
        return vc
    }
    
    // MARK: - Components -
    
    @IBOutlet weak private var searchComponentsContainer: UIStackView!
    
    @IBOutlet weak private var segmentTitleLabel: UILabel!
    @IBOutlet weak private var filterSegments: UISegmentedControl!
    
    @IBOutlet weak private var searchByLabel: UILabel!
    @IBOutlet weak private var searchTypeSegments: UISegmentedControl!
    
    @IBOutlet weak private var searchTextField: UITextField!
    @IBOutlet weak private var tableView: UITableView!
    
    @IBOutlet weak private var searchButtonContainer: UIStackView!
    @IBOutlet weak private var searchButton: UIButton!
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    private lazy var stateLabel = UILabel()
    
    // MARK: - DataProviders
    
    private lazy var tableDataProvider: StationTableViewDataProvider = {
        let dataProvider = StationTableViewDataProvider(tableView, styles.stationCellStyle)
        return dataProvider
    }()
    
    // MARK: - Properties -
    
    private var selectedStationTypeIndex: Int = 0
    private var selectedStationSearchTypeIndex: Int = 0
    private lazy var tapOnScreen = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
    private var searchComponentsArray: [UIView] = []
    
    private var viewModel: StationSceneViewModelable!
    private var styles: StationSceneStylable!
    
    // MARK: - ViewController Lifecycle -
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        requestStations(for: nil)
//        requestStationDataByName("Bayside", minutes: 90)
//        requestStationDataByCode("mhide", minutes: 20)
//        requestStationsFilter("br")
        setup()
        changeState(to: .empty)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        searchComponentsArray = []
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Scene State Machine -
    
    fileprivate var currentState: SceneState = .displaying
    
    fileprivate lazy var emptyStateComponents: [UIView] = [stateLabel]
    fileprivate lazy var errorStateComponents: [UIView] = [stateLabel]
    fileprivate lazy var loadingStateComponents: [UIView] = [activityIndicator]
    fileprivate lazy var displayingStateComponents: [UIView] = [tableView]
    
    // TODO: - add associated values to every state and hold state ViewModel there
    fileprivate enum SceneState {
        case empty
        case loading
        case displaying
        case error
    }
    
    // TODO: - Make state transitioning to use Generics
    fileprivate func changeState(to newState: SceneState) {
        
        if newState == .loading {
            guard currentState != .loading else {
                print("Station Scene: invalid state transition - to loading")
                return
            }
            updateLoadingStateComponents(.in)
            switch currentState {
            case .displaying:
                updateDisplayComponents(.out)
            case .empty:
                updateEmptyStateComponents(.out)
            case .error:
                updateErrorStateComponents(.out)
            default:
                break
            }
        }
        
        if newState != .loading {
            guard currentState != .loading else {
                print("Station Scene: invalid state transition - from loading")
                return
            }
            updateLoadingStateComponents(.out)
            switch currentState {
            case .displaying:
                updateDisplayComponents(.in)
            case .empty:
                updateEmptyStateComponents(.in)
            case .error:
                updateErrorStateComponents(.in)
            default:
                break
            }
        }
        
        currentState = newState
        
    }
    
    fileprivate enum TransitionType {
        case `out`
        case `in`
    }
    
    fileprivate func updateEmptyStateComponents(_ transition: TransitionType) {
        let shouldHide = transition == .out
        if transition == .in {
            stateLabel.text = viewModel.getEmptyStateText()
        }
        emptyStateComponents.forEach {
            $0.isHidden = shouldHide
        }
    }
    
    fileprivate func updateLoadingStateComponents(_ transition: TransitionType) {
        let shouldHide = transition == .out
        loadingStateComponents.forEach {
            $0.isHidden = shouldHide
        }
    }
    
    fileprivate func updateDisplayComponents(_ transition: TransitionType) {
        let shouldHide = transition == .out
        displayingStateComponents.forEach {
            $0.isHidden = shouldHide
        }
    }
    
    fileprivate func updateErrorStateComponents(_ transition: TransitionType) {
        let shouldHide = transition == .out
        errorStateComponents.forEach {
            $0.isHidden = shouldHide
        }
    }
    
}

// MARK: - @IBActions

private extension StationSceneViewController {
    
    @IBAction func onSearchButtonPressed() {
        
        let searchTypes = StationSearchType.allCases
        let selectedSearchType = searchTypes[selectedStationSearchTypeIndex]
        
        switch selectedSearchType {
        case .code:
            requestStationDataByCode(searchTextField.text ?? "", minutes: 0)
        case .filter:
            requestStationsFilter(searchTextField.text ?? "")
        case .name:
            requestStationDataByName(searchTextField.text ?? "", minutes: 0)
        case .type:
            requestStationForSelectedType()
        }
        
    }
    
}

private extension StationSceneViewController {
    
    func setup() {
        
        stateLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stateLabel)
        
        NSLayoutConstraint.activate([
            stateLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 24),
            stateLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        ])
        
        stateLabel.font = styles.stateTextFont
        stateLabel.textColor = styles.stateTextColor
        stateLabel.text = viewModel.getEmptyStateText()
        
        // use this array to hold strong refference to search components. When we want to hide some of them by removing it from superview we need this strong refference to not be deallocated (IBOutlets become nil because they're weak)
        searchComponentsArray = [segmentTitleLabel, searchTextField, searchByLabel, filterSegments, searchTypeSegments, searchButton]
        
        title = viewModel.getTitle()
        segmentTitleLabel.text = viewModel.getStationTypeSegmentTitleLabel()
        segmentTitleLabel.font = styles.segmentTitleFont
        segmentTitleLabel.textColor = styles.segmentTitleLabelColor
        searchTextField.font = styles.searchTextFont
        searchTextField.textColor = styles.searchTextColor
        searchTextField.delegate = self
        searchTextField.autocorrectionType = .no
        
        tapOnScreen.cancelsTouchesInView = false
        view.addGestureRecognizer(tapOnScreen)
        
        searchByLabel.font = styles.segmentTitleFont
        searchByLabel.textColor = styles.segmentTitleLabelColor
        searchByLabel.text = viewModel.getStationSearchTypeSegmentTitleLabel()
        
        searchButton.backgroundColor = styles.searchButtonBackgroundColor
        searchButton.setTitle(viewModel.searchButtonTitle, for: .normal)
        searchButton.setTitle(viewModel.searchButtonTitle, for: .selected)
        searchButton.setTitleColor(styles.searchButtonTitleColor, for: .normal)
        searchButton.setTitleColor(styles.searchButtonTitleColor, for: .selected)
        searchButton.layer.cornerRadius = styles.searchButtonCornerRadius
        
        setupFilterSegmentComponent()
        setupStationTypeSegmentComponent()
        updateSearchComponentsVisibility()
        updateSearchTextPlaceholder()
        
    }
    
    func requestStationDataByName(_ name: String, minutes: Int?) {
        changeState(to: .loading)
        viewModel.getStationDataByName(name: name, minutes: minutes) { [weak self] result in
            switch result {
            case .success(let layout):
                if !layout.isEmpty {
                    self?.changeState(to: .displaying)
                } else {
                    self?.changeState(to: .empty)
                }
                self?.tableDataProvider.load(layout)
            case .failure(let error):
                self?.stateLabel.text = error.localizedDescription
                self?.changeState(to: .error)
            }
        }
    }
    
    func requestStationDataByCode(_ code: String, minutes: Int?) {
        changeState(to: .loading)
        viewModel.getStationDataByCode(code: code, minutes: minutes) { [weak self] result in
            switch result {
            case .success(let layout):
                if !layout.isEmpty {
                    self?.changeState(to: .displaying)
                } else {
                    self?.changeState(to: .empty)
                }
                self?.tableDataProvider.load(layout)
            case .failure(let error):
                self?.stateLabel.text = error.localizedDescription
                self?.changeState(to: .error)
            }
        }
    }
    
    func requestStations(for type: StationType?) {
        changeState(to: .loading)
        viewModel.getAllStations(type: type) { [weak self] result in
            switch result {
            case .success(let layout):
                if !layout.isEmpty {
                    self?.changeState(to: .displaying)
                } else {
                    self?.changeState(to: .empty)
                }
                self?.tableDataProvider.load(layout)
            case .failure(let error):
                self?.stateLabel.text = error.localizedDescription
                self?.changeState(to: .error)
            }
        }
    }
    
    func requestStationsFilter(_ filter: String) {
        changeState(to: .loading)
        viewModel.getStationsFilter(filter: filter) { [weak self] result in
            switch result {
            case .success(let layout):
                if !layout.isEmpty {
                    self?.changeState(to: .displaying)
                } else {
                    self?.changeState(to: .empty)
                }
                self?.tableDataProvider.load(layout)
            case .failure(let error):
                self?.stateLabel.text = error.localizedDescription
                self?.changeState(to: .error)
            }
        }
    }
    
    func requestStationForSelectedType() {
        let types = viewModel.getStationTypes()
        let selectedType = types[selectedStationTypeIndex]
        requestStations(for: selectedType)
    }
    
    func setupFilterSegmentComponent() {
        filterSegments.removeAllSegments()
        filterSegments.selectedSegmentTintColor = styles.selectedSegmentTintColor
        for (index, type) in viewModel.getStationTypes().enumerated() {
            filterSegments.insertSegment(withTitle: type.title,
                                                at: index, animated: true)
        }
        let normalAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: styles.segmentTitleFont,
            NSAttributedString.Key.foregroundColor: styles.normalSegmentTitleColor
        ]
        filterSegments.setTitleTextAttributes(normalAttributes, for: .normal)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: styles.segmentTitleFont,
            NSAttributedString.Key.foregroundColor: styles.selectedSegmentTitleColor
        ]
        filterSegments.setTitleTextAttributes(selectedAttributes, for: .selected)
        filterSegments.selectedSegmentIndex = selectedStationTypeIndex
        
        filterSegments.addTarget(self,
                                 action: #selector(onStationTypeSegmentComponentDidChange),
                                 for: .valueChanged)
    }
    
    func setupStationTypeSegmentComponent() {
        searchTypeSegments.removeAllSegments()
        searchTypeSegments.selectedSegmentTintColor = styles.selectedSegmentTintColor
        for (index, type) in StationSearchType.allCases.enumerated() {
            searchTypeSegments.insertSegment(withTitle: type.title,
                                             at: index,
                                             animated: true)
        }
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: styles.segmentTitleFont,
            NSAttributedString.Key.foregroundColor: styles.normalSegmentTitleColor
        ]
        searchTypeSegments.setTitleTextAttributes(normalAttributes, for: .normal)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: styles.segmentTitleFont,
            NSAttributedString.Key.foregroundColor: styles.selectedSegmentTitleColor
        ]
        searchTypeSegments.setTitleTextAttributes(selectedAttributes, for: .selected)
        searchTypeSegments.selectedSegmentIndex = selectedStationSearchTypeIndex
        
        searchTypeSegments.addTarget(self,
                                     action: #selector(onStationSearchTypeSegmentComponentDidChange),
                                     for: .valueChanged)
    }
    
    @objc
    func onStationTypeSegmentComponentDidChange() {
        selectedStationTypeIndex = filterSegments.selectedSegmentIndex
        let types = viewModel.getStationTypes()
        let selectedType = types[selectedStationTypeIndex]
        requestStations(for: selectedType)
    }
    
    @objc
    func onStationSearchTypeSegmentComponentDidChange() {
        selectedStationSearchTypeIndex = searchTypeSegments.selectedSegmentIndex
        updateSearchComponentsVisibility()
        updateSearchTextPlaceholder()
        
        let searchTypes = StationSearchType.allCases
        let selectedSearchType = searchTypes[selectedStationSearchTypeIndex]
        guard selectedSearchType == .type else { return }
        
        requestStationForSelectedType()
    }
    
    func updateSearchComponentsVisibility() {
        let types = StationSearchType.allCases
        let selectedType = types[selectedStationSearchTypeIndex]
        let searchByType = selectedType == .type
        _updateStationTypeVisibility(searchByType)
        _updateSearchTextVisibility(!searchByType)
    }
    
    func updateSearchTextPlaceholder() {
        let type = StationSearchType.allCases[selectedStationSearchTypeIndex]
        searchTextField.placeholder = "Type \(type.title) Here"// TODO: - Localize
        searchTextField.text = nil
    }
    
    func _updateStationTypeVisibility(_ visible: Bool) {
        if visible {
            guard filterSegments.superview == nil else { return }
            searchComponentsContainer.insertArrangedSubview(segmentTitleLabel, at: 2)
            searchComponentsContainer.insertArrangedSubview(filterSegments, at: 3)
        } else {
            guard filterSegments.superview != nil else { return }
            filterSegments.removeFromSuperview()
            segmentTitleLabel.removeFromSuperview()
        }
    }
    
    func _updateSearchTextVisibility(_ visible: Bool) {
        if visible {
            guard searchTextField.superview == nil else { return }
            searchComponentsContainer.insertArrangedSubview(searchTextField, at: 2)
            searchButtonContainer.insertArrangedSubview(searchButton, at: 1)
        } else {
            guard searchTextField.superview != nil else { return }
            searchTextField.removeFromSuperview()
            searchButton.removeFromSuperview()
        }
    }

}

// MARK: - UITextFieldDelegate -

extension StationSceneViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
}

// MARK: - Internal Types -

fileprivate extension StationSceneViewController {

    enum StationSearchType: CaseIterable {
        
        case code
        case name
        case filter
        case type
        
        var title: String {
            switch self {
            case .code:
                return "lstr_station_search_type_code".localized()
            case .name:
                return "lstr_station_search_type_name".localized()
            case .filter:
                return "lstr_station_search_type_filter".localized()
            case .type:
                return "lstr_station_search_type_type".localized()
            }
        }
        
    }
    
}

// MARK: - Styles -

protocol StationSceneStylable {
    
    var stateTextFont: UIFont { get }
    var stateTextColor: UIColor { get }
    
    var backgroundColor: UIColor { get }
    var segmentTitleLabelColor: UIColor { get }
    var selectedSegmentTintColor: UIColor { get }
    var segmentTitleFont: UIFont { get }
    var normalSegmentTitleColor: UIColor { get }
    var selectedSegmentTitleColor: UIColor { get }
    var searchTextFont: UIFont { get }
    var searchTextColor: UIColor { get }
    var searchTextFieldBackground: UIColor { get }
    var searchButtonBackgroundColor: UIColor { get }
    var searchButtonTitleFont: UIFont { get }
    var searchButtonTitleColor: UIColor { get }
    var searchButtonCornerRadius: CGFloat { get }
    
    var stationCellStyle: StationCellStylable { get }
}

extension StationSceneViewController {
    
    struct DefaultStationSceneStyles: StationSceneStylable {
        var stateTextFont: UIFont
        var stateTextColor: UIColor
        var backgroundColor: UIColor
        var segmentTitleLabelColor: UIColor
        var selectedSegmentTintColor: UIColor
        var segmentTitleFont: UIFont
        var normalSegmentTitleColor: UIColor
        var selectedSegmentTitleColor: UIColor
        var searchTextFont: UIFont
        var searchTextColor: UIColor
        var searchTextFieldBackground: UIColor
        var searchButtonBackgroundColor: UIColor
        var searchButtonTitleFont: UIFont
        var searchButtonTitleColor: UIColor
        var searchButtonCornerRadius: CGFloat
        
        var stationCellStyle: StationCellStylable
    }
    
}
