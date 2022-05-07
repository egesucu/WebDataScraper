//
//  Date+Extensions.swift
//  WebDataScraper
//
//  Created by Ege Sucu on 6.05.2022.
//

import Foundation

extension Date{
    func isInToday(date: Date) -> Bool{
        return self == date
    }
    
    func esDate() -> String{
        return self.formatted(.dateTime.day().month(.wide).year().locale(.init(identifier:"en_GB")))
    }
    
    func isOlderThanToday(date: Date) -> Bool {
        return self < date
    }
}
