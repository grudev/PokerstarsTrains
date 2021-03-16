//
//  AppTheme.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

final class AppTheme {
    
    // MARK: - Color Definitions
    
    struct Colors {
        
        static let irishGreen = UIColor(named: "irishGreen") ?? UIColor.black
        static let stPatrickBlue = UIColor(named: "stPatrickBlue") ?? UIColor.black
        static let white = UIColor.white
        static let gray = UIColor.darkGray
        static let lightGray = UIColor.lightGray
        
        struct Text {
            static var `default`: UIColor { gray }
            static var subtitle: UIColor { lightGray }
            static var buttonTitle: UIColor { white }
        }
        
    }
    
    struct Text {
        static func appFont(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    struct Layout {
        static let defaultCornerRadius: CGFloat = 5
    }
    
    // MARK: - Apply General Theme
    
    static func applyGeneralTheme() {
        UINavigationBar.appearance().barTintColor = Colors.irishGreen
        UINavigationBar.appearance().tintColor = Colors.white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.white
        ]
        UINavigationBar.appearance().isTranslucent = false

        UIToolbar.appearance().barTintColor = Colors.irishGreen
        UIToolbar.appearance().tintColor = Colors.irishGreen
    }
    
}

extension AppTheme {
    
    static func makeMainSceneStyles() -> MainSceneStylable {
        return MainSceneViewController.DefaultMainSceneStyles(
            backgroundColor: Colors.white,
            buttonBackgroundColor: Colors.stPatrickBlue,
            buttonTitleColor: Colors.Text.buttonTitle,
            buttonCornerRadius: Layout.defaultCornerRadius
        )
    }
    
    static func makeStationSceneStyles() -> StationSceneStylable {
        let cellStyle = StationCell.StyleSheet(evenCellBackgroundColor: Colors.white,
                                               oddCellBackgroundColor: Colors.lightGray.withAlphaComponent(0.5),
                                               textFont: Text.appFont(size: 14),
                                               textColor: Colors.Text.default)
        
        return StationSceneViewController.DefaultStationSceneStyles(stateTextFont: Text.appFont(size: 16),
                                                                    stateTextColor: Colors.Text.default,
                                                                    backgroundColor: Colors.white,
                                                                    segmentTitleLabelColor: Colors.Text.default,
                                                                    selectedSegmentTintColor: Colors.stPatrickBlue,
                                                                    segmentTitleFont: Text.appFont(size: 14),
                                                                    normalSegmentTitleColor: Colors.gray,
                                                                    selectedSegmentTitleColor: Colors.white,
                                                                    searchTextFont: Text.appFont(size: 14),
                                                                    searchTextColor: Colors.gray,
                                                                    searchTextFieldBackground: Colors.lightGray,
                                                                    searchButtonBackgroundColor: Colors.irishGreen,
                                                                    searchButtonTitleFont: Text.appFont(size: 14),
                                                                    searchButtonTitleColor: Colors.white,
                                                                    searchButtonCornerRadius: Layout.defaultCornerRadius,
                                                                    stationCellStyle: cellStyle)
    }
    
    static func makeTrainSceneStyles() -> TrainSceneStylable {
        
        let cellStyles = TrainCell.StyleSheet(backgroundColor: Colors.white,
                                              statusLabelFont: Text.appFont(size: 14),
                                              statusLabelColor: Colors.gray,
                                              messageLabelFont: Text.appFont(size: 14),
                                              messageLabelColor: Colors.gray,
                                              directionLabelFont: Text.appFont(size: 14),
                                              directionLabelColor: Colors.gray,
                                              oddCellBackgroundColor: Colors.lightGray.withAlphaComponent(0.5),
                                              evenCellBackgroundColor: Colors.white,
                                              locationButtonTitleFont: Text.appFont(size: 14),
                                              locationButtonTitleColor: Colors.white,
                                              locationButtonNormalColor: Colors.stPatrickBlue,
                                              locationButtonHighlightedColor: Colors.stPatrickBlue,
                                              locationButtonCornerRadius: Layout.defaultCornerRadius)
        
        return TrainSceneViewController.DefaultTrainSceneStyles(backgroundColor: Colors.white,
                                                                trainSegmentTitleFont: Text.appFont(size: 14),
                                                                trainSegmentTitleColor: Colors.gray,
                                                                selectedSegmentTintColor: Colors.stPatrickBlue,
                                                                segmentTitleFont: Text.appFont(size: 11),
                                                                normalSegmentTitleColor: Colors.gray,
                                                                selectedSegmentTitleColor: Colors.white,
                                                                cellStyles: cellStyles)
    }
    
    static func makeTrainDetailsSceneStyles() -> TrainDetailsSceneStylable {
        let tableViewStyles = TrainDetailsSceneDataProvider.StyleSheet(
            textFont: Text.appFont(size: 14),
            textColor: Colors.gray,
            evenCellBackgroundColor: Colors.white,
            oddCellBackgroundColor: Colors.lightGray.withAlphaComponent(0.5)
        )
        return TrainDetailsSceneViewController.DefaultTrainDetailsSceneStyles(
            backgroundColor: Colors.white, tableViewStyles: tableViewStyles
        )
    }
    
}
