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
}
