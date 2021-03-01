//
//  Identifiable.swift
//  Trains
//
//  Created by Dimitar Grudev on 27.02.21.
//

import UIKit

public protocol Identifiable {
    static var uniqueIdentifier: String { get }
}

public extension Identifiable {
    static var uniqueIdentifier: String { String(describing: self) }
}

extension UICollectionViewCell: Identifiable { }
