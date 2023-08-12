//
//  TableViewModel.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import Foundation

protocol TableViewModel {
    var rowCount: Int { get }
    func getWebViewURL(forIndex index: Int) -> URL?
    func getCellViewModel(forIndex index: Int) -> NewsItemViewModel?
}
