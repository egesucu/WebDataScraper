//
//  DataService.swift
//  WebDataScraper
//
//  Created by Ege Sucu on 6.05.2022.
//

import Foundation
import SwiftSoup

class DataService: ObservableObject{
    
    @Published var articleList = [Article]()
    let baseURL = URL(string: "https://www.swiftbysundell.com")
    
    
    func fetchArticles(){
        articleList.removeAll()
        let articleURL = baseURL?.appendingPathComponent("articles")
        
        if let articleURL = articleURL{
            do {
                let websiteString = try String(contentsOf: articleURL)
                let document = try SwiftSoup.parse(websiteString)
                
                let articles = try document.getElementsByClass("item-list").select("article")
                
                for article in articles{
                    let title = try article.select("a").first()?.text(trimAndNormaliseWhitespace: true) ?? ""
                    guard let baseURL = baseURL else {
                        return
                    }
                    let url = try baseURL.appendingPathComponent(article.select("a").attr("href"))
                    let dateString = try article.select("div").select("span").text()
                        .replacingOccurrences(of: "Published on ", with: "")
                        .replacingOccurrences(of: "Remastered on ", with: "")
                        .replacingOccurrences(of: "Answered on ", with: "")
                        .trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    let formatter = DateFormatter(dateFormat: "dd MMM yyyy")
                    let date = Calendar.current.startOfDay(for: formatter.date(from: dateString) ?? Date.now)
                    
                    let post = Article(title: title, url: url, publishDate: date)
                    self.articleList.append(post)
                }
                
            } catch let error {
                print(error)
            }
        }
        
    }
    
}
