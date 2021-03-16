//
//  TrainCell.swift
//  Trains
//
//  Created by Dimitar Grudev on 8.03.21.
//

import UIKit
import MapKit

class TrainCell: UITableViewCell {
    
    @IBOutlet weak private var statusLabel: UILabel!
    @IBOutlet weak private var messageTextView: UITextView!
    @IBOutlet weak private var directionLabel: UILabel!
    @IBOutlet weak private var locationButton: UIButton!
    
    private var viewModel: TrainCellViewModel!
    private var styleSheet: TrainCellStylable!
    
    func config(_ viewModel: TrainCellViewModel, _ styleSheet: TrainCellStylable) {
        self.viewModel = viewModel
        self.styleSheet = styleSheet
        setup()
    }
    
}

// MARK: - IBActions

extension TrainCell {
    
    @IBAction func onLocationButtonPressed(_ sender: UIButton) {
        
        let latitude: CLLocationDegrees = viewModel.trainPosition.latitude
        let longitude: CLLocationDegrees = viewModel.trainPosition.longitude

        let regionDistance: CLLocationDistance = K.Map.locationDinstance
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates,
                                            latitudinalMeters: regionDistance,
                                            longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = viewModel.trainPosition.code
        mapItem.openInMaps(launchOptions: options)
        
    }
    
}

private extension TrainCell {
    
    func setup() {
        setupStyles()
        
        statusLabel.text = viewModel.status
        messageTextView.text = viewModel.message
        directionLabel.text = viewModel.direction
    }
    
    func setupStyles() {
        
        statusLabel.font = styleSheet.statusLabelFont
        statusLabel.textColor = styleSheet.statusLabelColor
        
        messageTextView.font = styleSheet.messageLabelFont
        messageTextView.textColor = styleSheet.messageLabelColor
        messageTextView.backgroundColor = .clear

        directionLabel.font = styleSheet.directionLabelFont
        directionLabel.textColor = styleSheet.directionLabelColor

        let buttonTitle = viewModel.getLocationButtonTitle()
        let locationButtonTitleNormalAttr: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: styleSheet.locationButtonTitleFont,
            NSAttributedString.Key.backgroundColor: styleSheet.locationButtonNormalColor
        ]
        let locationButtonTitleNormal = NSAttributedString(string: buttonTitle,
                                                           attributes: locationButtonTitleNormalAttr)
        locationButton.setAttributedTitle(locationButtonTitleNormal, for: .normal)

        let locationButtonTitleHighlightedAttr: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.font: styleSheet.locationButtonTitleFont,
            NSAttributedString.Key.backgroundColor: styleSheet.locationButtonHighlightedColor
        ]
        let locationButtonTitleHighlighted = NSAttributedString(string: buttonTitle,
                                                                attributes: locationButtonTitleHighlightedAttr)
        locationButton.setAttributedTitle(locationButtonTitleHighlighted, for: .highlighted)
        locationButton.backgroundColor = styleSheet.locationButtonNormalColor
        locationButton.layer.cornerRadius = styleSheet.locationButtonCornerRadius
        
    }
    
}

// MARK: - Local Constants -

private extension TrainCell {
    struct K {
        struct Map {
            static let locationDinstance: Double = 100
        }
    }
}

// MARK: - Styles -

protocol TrainCellStylable {
    
    var backgroundColor: UIColor { get }
    
    var statusLabelFont: UIFont { get }
    var statusLabelColor: UIColor { get }
    
    var messageLabelFont: UIFont { get }
    var messageLabelColor: UIColor { get }
    
    var directionLabelFont: UIFont { get }
    var directionLabelColor: UIColor { get }
    
    var oddCellBackgroundColor: UIColor { get }
    var evenCellBackgroundColor: UIColor { get }
    
    var locationButtonTitleFont: UIFont { get }
    var locationButtonTitleColor: UIColor { get }
    var locationButtonNormalColor: UIColor { get }
    var locationButtonHighlightedColor: UIColor { get }
    
    var locationButtonCornerRadius: CGFloat { get }
    
}

extension TrainCell {
    class StyleSheet: TrainCellStylable {
        
        var backgroundColor: UIColor
        
        var statusLabelFont: UIFont
        var statusLabelColor: UIColor
        
        var messageLabelFont: UIFont
        var messageLabelColor: UIColor
        
        var directionLabelFont: UIFont
        var directionLabelColor: UIColor
        
        var oddCellBackgroundColor: UIColor
        var evenCellBackgroundColor: UIColor
        
        var locationButtonTitleFont: UIFont
        var locationButtonTitleColor: UIColor
        var locationButtonNormalColor: UIColor
        var locationButtonHighlightedColor: UIColor
        
        var locationButtonCornerRadius: CGFloat
        
        init(backgroundColor: UIColor,
             statusLabelFont: UIFont,
             statusLabelColor: UIColor,
             messageLabelFont: UIFont,
             messageLabelColor: UIColor,
             directionLabelFont: UIFont,
             directionLabelColor: UIColor,
             oddCellBackgroundColor: UIColor,
             evenCellBackgroundColor: UIColor,
             locationButtonTitleFont: UIFont,
             locationButtonTitleColor: UIColor,
             locationButtonNormalColor: UIColor,
             locationButtonHighlightedColor: UIColor,
             locationButtonCornerRadius: CGFloat) {
            
            self.backgroundColor = backgroundColor
            self.statusLabelFont = statusLabelFont
            self.statusLabelColor = statusLabelColor
            self.messageLabelFont = messageLabelFont
            self.messageLabelColor = messageLabelColor
            self.directionLabelFont = directionLabelFont
            self.directionLabelColor = directionLabelColor
            self.oddCellBackgroundColor = oddCellBackgroundColor
            self.evenCellBackgroundColor = evenCellBackgroundColor
            self.locationButtonTitleFont = locationButtonTitleFont
            self.locationButtonTitleColor = locationButtonTitleColor
            self.locationButtonNormalColor = locationButtonNormalColor
            self.locationButtonHighlightedColor = locationButtonHighlightedColor
            self.locationButtonCornerRadius = locationButtonCornerRadius
            
        }
        
    }
}
