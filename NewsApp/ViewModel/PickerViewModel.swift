//
//  PickerViewModel.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import Foundation

typealias ChosenOption = (title: String, selected: Bool)

final class PickerViewModel {
    
    private let networkService = NetworkService.shared
    
    private let type: Filter
    var opions = [ChosenOption]()
    
    var rowCount: Int {
        opions.count
    }
    
    init(type: Filter) {
        self.type = type
        updateItems()
    }
    
    func selectItem(withIndex index: Int) {
        switch type {
        case .country:
            networkService.country = Country(rawValue: opions[index].title) ?? .none
        case .category:
            networkService.category = Category(rawValue: opions[index].title) ?? .none
        }
        updateItems()
    }
    
    private func updateItems() {
        switch type {
        case .country:
            self.opions = type.getOptions().map { ($0, networkService.country == Country(rawValue: $0)) }
        case .category:
            self.opions = type.getOptions().map { ($0, networkService.category == Category(rawValue: $0)) }
        }
    }
}
