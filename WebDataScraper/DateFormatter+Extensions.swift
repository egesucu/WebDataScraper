//
//  DateFormatter+Extensions.swift
//  WebDataScraper
//
//  Created by Ege Sucu on 7.05.2022.
//

import Foundation

extension DateFormatter {
    convenience init(dateFormat: String) {
        self.init()
        self.locale = Locale(identifier: "en_US_POSIX")
        self.timeZone = TimeZone(secondsFromGMT: 0)
        self.dateFormat =  dateFormat
    }
}
