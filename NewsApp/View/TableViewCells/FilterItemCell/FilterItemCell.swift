//
//  FilterItemCell.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import UIKit

final class FilterItemCell: UITableViewCell {
    
    static let identifier = "FilterItemCell"
    static let height: CGFloat = 56
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var optionLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        optionLabel.text = nil
    }
    
    func configure(with model: FilterCase) {
        titleLabel.text = model.title
        optionLabel.text = model.item
    }
}
