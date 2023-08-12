//
//  Article.swift
//  NewsApp
//
//  Created by Marta Korol on 09.08.2023.
//

import Foundation

struct Article: Codable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?
    
    init(source: Source?, author: String?, title: String?, description: String?, url: String?, urlToImage: String?, publishedAt: String?, content: String?) {
        self.source = source
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.content = content
    }
    
    init(from entity: ArticleEntity) {
        self.source = Source(from: entity.source!) //TODO: fix
        self.author = entity.author
        self.title = entity.title
        self.description = entity.description
        self.url = entity.url
        self.urlToImage = entity.urlToImage
        self.publishedAt = entity.publishedAt
        self.content = entity.content
    }
}
