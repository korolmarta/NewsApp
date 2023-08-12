//
//  SavedNewsViewModel.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation

final class SavedNewsViewModel: TableViewModel {

    private let coreDataService = CoreDataService.shared

    private var entities = [ArticleEntity]()
    
    var rowCount: Int {
        entities.count
    }
    
    func getCellViewModel(forIndex index: Int) -> NewsItemViewModel? {
        guard index < rowCount else { return nil }
        return NewsItemViewModel(entity: entities[index])
    }
    
    func getWebViewURL(forIndex index: Int) -> URL? {
        guard index < rowCount, let urlString = entities[index].url, let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    func loadData() {
        entities = coreDataService.fetchArticles()
    }
}
