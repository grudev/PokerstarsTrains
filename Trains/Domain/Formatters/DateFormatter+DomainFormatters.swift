//
//  DateFormatter+DomainFormatters.swift
//  Trains
//
//  Created by Dimitar Grudev on 2.03.21.
//

import Foundation

extension DateFormatter {
    
    static var trainMovementsDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "d MMM yyyy"
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        return formatter
    }()
    
}
