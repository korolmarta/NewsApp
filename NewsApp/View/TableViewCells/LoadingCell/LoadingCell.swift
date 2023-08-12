//
//  LoadingCell.swift
//  NewsApp
//
//  Created by Marta Korol on 11.08.2023.
//

import UIKit

final class LoadingCell: UITableViewCell {

    static let identifier = "LoadingCell"
    static let height: CGFloat = 50
    
    @IBOutlet weak private var activityIndicator: UIActivityIndicatorView!
    
    func startAnimating() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
    }
}
