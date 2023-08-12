//
//  Categoty.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import Foundation

enum Category: String, CaseIterable {
    
    case none = "None"
    case business = "Business"
    case entertainment = "Entertainment"
    case general = "General"
    case health = "Health"
    case science = "Science"
    case sports = "Sports"
    case technology = "Technology"
    
    var value: String {
        self.rawValue.lowercased()
    }
}
