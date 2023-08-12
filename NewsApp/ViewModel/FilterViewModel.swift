//
//  FilterViewModel.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import Foundation

typealias FilterCase = (title: String, item: String)

final class FilterViewModel {
    
    private let networkService = NetworkService.shared
    private let filters = Filter.allCases.map { $0.rawValue }
    
    var rowCount: Int {
        filters.count
    }
    
    func getPickerViewModel(forIndex index: Int) -> PickerViewModel? {
        guard index < filters.count, let type = Filter(rawValue: filters[index]) else {
            return nil
        }
        return PickerViewModel(type: type)
    }
    
    func getFilterCase(forIndex index: Int) -> FilterCase {
        guard index < filters.count else {
            return ("", "")
        }
        return (filters[index], getSelectedItem(forIndex: index))
    }
    
    private func getSelectedItem(forIndex index: Int) -> String {
        guard index < filters.count, let type = Filter(rawValue: filters[index]) else {
            return ""
        }
        switch type {
        case .category: return networkService.category.rawValue
        case .country: return networkService.country.rawValue
        }
    }
}
