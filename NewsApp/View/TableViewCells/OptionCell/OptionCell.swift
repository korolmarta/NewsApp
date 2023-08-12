//
//  OptionCell.swift
//  NewsApp
//
//  Created by Marta Korol on 12.08.2023.
//

import UIKit

class OptionCell: UITableViewCell {

    static let identifier = "OptionCell"
    static let height: CGFloat = 44
    
    @IBOutlet weak private var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        accessoryType = .none
    }
    
    func configure(with option: ChosenOption) {
        titleLabel.text = option.title
        accessoryType = option.selected ? .checkmark : .none
    }
}
