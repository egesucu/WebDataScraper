//
//  ArticleListView.swift
//  WebDataScraper
//
//  Created by Ege Sucu on 6.05.2022.
//

import SwiftUI

struct ArticleListView: View {
    
    @ObservedObject var data = DataService()
    @State private var searchText = ""
    let today = Calendar.current.startOfDay(for: .now)
    
    var body: some View {
        NavigationView {
            List{
                Section {
                    if todaysResults().count == 0{
                        HStack{
                            Spacer()
                            Text("No Post")
                                .bold()
                            Spacer()
                        }
                    } else {
                        ForEach(todaysResults()) { article in
                            ArticleCell(article: article, isDateToday: true)
                        }
                    }
                } header: {
                    Text("Today")
                } footer: {
                    if searchResults.filter({$0.publishDate.isInToday(date: today)}).count > 0{
                        Text("\(todaysResults().count) Article(s)")
                            .background(.clear)
                    }
                }
                
                Section {
                    if previousResults().count == 0{
                        Text("No Results")
                    } else {
                        ForEach(previousResults()) { article in
                            ArticleCell(article: article, isDateToday: false)
                        }
                    }
                } header: {
                    Text(oldPostsHeader)
                } footer: {
                    if previousResults().count == 0{
                        
                    } else {
                        Text("\(previousResults().count) Article(s)")
                    }
                }
            }
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always))
            .refreshable {
                fetchData()
            }
            .disableAutocorrection(true)
            .onAppear(perform: fetchData)
            .navigationTitle(Text("Articles"))
        }
    }
    
    func todaysResults() -> [Article]{
        return searchResults.filter({ $0.publishDate.isInToday(date: today) })
    }
    
    func previousResults() -> [Article]{
        return searchResults.filter({ $0.publishDate.isOlderThanToday(date: today) })
    }
    
    var searchResults : [Article] {
        if searchText.isEmpty{
            return data.articleList
        } else {
            return data.articleList.filter({
                $0.title.lowercased().localizedStandardContains(searchText.lowercased())
                ||
                $0.publishDate.esDate().localizedStandardContains(searchText.lowercased())
            })
        }
    }
    
    var oldPostsHeader : String{
        if searchText.isEmpty{
            return "Old Posts"
        } else {
            return "Results for " + searchText
        }
    }
    
    func fetchData(){
        data.fetchArticles()
    }
}

struct ArticleListView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleListView()
    }
}
