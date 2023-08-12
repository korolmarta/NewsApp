//
//  Source.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import Foundation

struct Source: Codable {
    let id: String?
    let name: String?
    let description: String?
    let url: String?
    let category: String?
    let language: String?
    let country: String?
    
    init(id: String?, name: String?, description: String?, url: String?, category: String?, language: String?, country: String?) {
        self.id = id
        self.name = name
        self.description = description
        self.url = url
        self.category = category
        self.language = language
        self.country = country
    }
    
    init(from entity: SourceEntity) {
        self.id = entity.id
        self.name = entity.name
        self.description = nil
        self.url = nil
        self.category = nil
        self.language = nil
        self.country = nil
    }
}
