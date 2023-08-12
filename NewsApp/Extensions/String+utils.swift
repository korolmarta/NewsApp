//
//  String+utils.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import Foundation

extension String {
    var requestFormat: String {
        // Remove leading and trailing whitespaces and make it lowercased
        var formattedText = self.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

        // Replace whitespaces between words with dashes
        return formattedText.replacingOccurrences(of: " ", with: "-")
    }
}
