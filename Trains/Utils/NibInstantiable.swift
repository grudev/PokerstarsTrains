//
//  NibInstantiable.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import UIKit

public protocol NibInstantiable {
    static var defaultFileName: String { get }
    static func instantiate() -> Self
}

public extension NibInstantiable where Self: UIView {
    
    static var defaultFileName: String { .init(describing: self) }
    
    static func instantiate() -> Self {
        return UINib(nibName: defaultFileName, bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! Self
    }
    
}
