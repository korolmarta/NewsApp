//
//  Response.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation

struct Response: Codable {
    let status: String?
    let totalResults: Int
    let articles: [Article]?
}
