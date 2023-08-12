//
//  NewsItemViewModel.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation

final class NewsItemViewModel {

    private let networkService = NetworkService.shared
    
    private(set) var article: Article
    private(set) var saved: Bool
    
    init(article: Article) {
        self.article = article
        self.saved = false
    }
    
    func getImageData(url: String, completion: @escaping (Data?) -> ()) {
        networkService.getImageData(url: url) { data in
            completion(data)
        }
    }
}
