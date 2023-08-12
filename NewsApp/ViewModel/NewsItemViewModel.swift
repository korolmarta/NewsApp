//
//  NewsItemViewModel.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation

final class NewsItemViewModel {

    private let networkService = NetworkService.shared
    private let coreDataService = CoreDataService.shared
    
    private(set) var article: Article
    private(set) var entity: ArticleEntity?
    private(set) var saved: Bool
    
    init(article: Article) {
        self.article = article
        self.saved = false
    }
    
    init(entity: ArticleEntity) {
        self.article = Article(from: entity)
        self.entity = entity
        self.saved = true
    }
    
    func getImageData(url: String, completion: @escaping (Data?) -> ()) {
        networkService.getImageData(url: url) { data in
            completion(data)
        }
    }
    
    func saveArticle(completion: @escaping (Bool) -> ()) {
        coreDataService.addArticle(articleData: article) { [weak self] success in
            guard let self = self else { return }
            self.saved = true
            completion(success)
        }
    }
    
    func deleteArticle(completion: @escaping (Bool) -> ()) {
        guard let entity = self.entity else { return }
        coreDataService.deleteArticle(article: entity) { [weak self] success in
            guard let self = self else { return }
            self.saved = false
            completion(success)
        }
    }
}
