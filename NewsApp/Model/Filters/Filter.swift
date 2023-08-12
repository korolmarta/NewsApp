//
//  Filter.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import Foundation

enum Filter: String, CaseIterable {
    case category = "Category"
    case country = "Country"
    
    func getOptions() -> [String] {
        switch self {
        case .category:
            return Category.allCases.map { $0.rawValue }
        case .country:
            return Country.allCases.map { $0.rawValue }
        }
    }
}
