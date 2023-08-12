//
//  NetworkService.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation
import Alamofire

final class NetworkService {
    
    static let shared = NetworkService()
    
    private let globalAPI = "https://newsapi.org/v2/"
    private let defaultQuery = "apple"
    private let defaultSortBy = "publishedAt"
    private let defaultCountry = Country.us.value
    /// Replace empty string with your API Key
    /// To get API Key visit https://newsapi.org/
    private let yourApiKey = ""
    
    var country: Country = .none
    var category: Category = .none
    
    private init() {}
    
    private func query(_ query: String?) -> String {
        var topHeadlines = "top-headlines?"
        guard let query = query else {
            return topHeadlines + filter
        }
        topHeadlines += "q=\(query)"
        if country != .none {
            topHeadlines += "&country=\(country.value)"
        }
        if category != .none {
            topHeadlines += "&category=\(category.value)"
        }
        return topHeadlines
    }
    
    private var filter: String {
        var filter = "country="
        filter += country != .none ? country.value : defaultCountry
        if category != .none {
            filter += "&category=\(category.value)"
        }
        return filter
    }
    
    private func page(_ page: Int, size: Int) -> String {
        "&page=\(page)" + "&pageSize=\(size)"
    }
    
    private func sort(_ sortBy: String?) -> String {
        "&sortBy=\(sortBy ?? defaultSortBy)"
    }
    
    private var apiKey: String {
        "&apiKey=\(yourApiKey)"
    }
    
    func getImageData(url: String, completion: @escaping (Data?) -> ()) {
        AF.request(url).responseData { request in
            completion(request.data)
        }
    }
    
    func request(query: String? = nil, page: Int = 1, pageSize: Int = 10, sortBy: String? = nil, completion: @escaping (Data?) -> ()) {
        let urlString: String = globalAPI + self.query(query) + self.page(page, size: pageSize) + sort(sortBy) + apiKey
        
        AF.request(urlString).response { response in
            debugPrint(response)
            completion(response.data)
        }
    }
}
