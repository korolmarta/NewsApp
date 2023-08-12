//
//  DiscoverViewModel.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation

final class DiscoverViewModel: TableViewModel {
    
    private let networkService = NetworkService.shared
    
    private var articles = [Article]()
    private var currentPage = 1
    private var totalResults = 0
    
    var isLoading: Bool = false {
        didSet {
            if isLoading {
                refreshUICallback?()
            }
        }
    }
    
    var refreshUICallback: (() -> ())?
    
    private var totalPages: Int {
        let pages = totalResults / 10 //TODO: 10 - constant
        return pages > 0 ? pages : 1
    }

    var rowCount: Int {
        articles.count
    }

    func getWebViewURL(forIndex index: Int) -> URL? {
        guard index < rowCount, let urlString = articles[index].url, let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    func getCellViewModel(forIndex index: Int) -> NewsItemViewModel? {
        guard index < articles.count else { return nil }
        return NewsItemViewModel(article: articles[index])
    }

    func loadData(with query: String? = nil, completion: @escaping () -> ()) {
        resetData()
        getData(with: query) { articles in
            guard let artcls = articles else { return } //TODO: refactor
            self.articles = artcls
            completion()
        }
    }

    func loadMoreData(forIndex index: Int, completion: @escaping () -> ()) {
        guard !isLoading, index == rowCount - 1, currentPage < totalPages else { return }
        isLoading = true
        currentPage += 1
        getData(page: currentPage) { articles in
            guard let artcls = articles else { return } //TODO: refactor
            self.articles += artcls
            self.isLoading = false
            completion()
        }
    }

    private func getData(with query: String? = nil, page: Int = 1, completion: @escaping ([Article]?) -> ()) {
        networkService.request(query: query?.lowercased(), page: page) { [weak self] data in
            let decoder = JSONDecoder()
            guard let data = data, let jsonModel = try? decoder.decode(Response.self, from: data) else {
                completion(nil)
                return
            }
            self?.totalResults = jsonModel.totalResults
            completion(jsonModel.articles)
        }
    }

    private func resetData() {
        articles = []
        currentPage = 1
    }
}
