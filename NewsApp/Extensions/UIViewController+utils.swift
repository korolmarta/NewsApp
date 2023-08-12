//
//  UIViewController + utils.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String, actionTitles: [String]) {
        let alert = UIAlertController(title: title, message:title, preferredStyle:.alert)
        actionTitles.forEach { title in
            alert.addAction(UIAlertAction(title: title, style: .default, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
}
