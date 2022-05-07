//
//  Article.swift
//  WebDataScraper
//
//  Created by Ege Sucu on 6.05.2022.
//

import Foundation

struct Article: Identifiable, Hashable{
    let id = UUID().uuidString
    var title: String
    var url : URL?
    var publishDate: Date
}
