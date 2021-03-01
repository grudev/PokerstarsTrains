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
        
        static let green = UIColor(named: "green") ?? UIColor.black
        static let white = UIColor.white
        static let gray = UIColor.darkGray
        static let lightGray = UIColor.lightGray
        
        struct Text {
            static var `default`: UIColor { gray }
        }
        
    }
    
    struct Text {
        static func appFont(size: CGFloat) -> UIFont {
            return UIFont.systemFont(ofSize: size)
        }
    }
    
    // MARK: - Apply General Theme
    
    static func applyGeneralTheme() {
        UINavigationBar.appearance().barTintColor = Colors.green
        UINavigationBar.appearance().tintColor = Colors.white
        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: Colors.white
        ]
        UINavigationBar.appearance().isTranslucent = false

        UIToolbar.appearance().barTintColor = Colors.green
        UIToolbar.appearance().tintColor = Colors.green
    }
    
}

extension AppTheme {
    
    static func makeMainSceneStyles() -> MainSceneStylable {
        let cellStyle = ItemCell.StyleSheet(backgroundColor: Colors.white,
                                            titleFont: Text.appFont(size: 16),
                                            titleColor: Colors.Text.default)
        return MainSceneViewController.DefaultMainSceneStyles(
            backgroundColor: Colors.white,
            cellStyle: cellStyle
        )
    }
    
}
