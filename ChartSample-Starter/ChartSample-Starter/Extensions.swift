//
//  Extensions.swift
//  ChartsSample-1
//
//  Created by Anthony Da cruz on 26/09/2022.
//

import Foundation

extension String {
    func simplestYearToDate() -> Date {
        let dateFormatter = DateFormatter()
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = "yy"
        let date = dateFormatter.date(from:self)!
        return date
    }
}
