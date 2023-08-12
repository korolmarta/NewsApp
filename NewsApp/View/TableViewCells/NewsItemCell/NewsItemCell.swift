//
//  NewsItemCell.swift
//  NewsApp
//
//  Created by Marta Korol on 09.08.2023.
//

import UIKit

final class NewsItemCell: UITableViewCell {

    static let identifier = "NewsItemCell"
    static let height: CGFloat = 128
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var dotLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!

    private var viewModel: NewsItemViewModel!

    private let bookmarkImage = UIImage(systemName: "bookmark")
    private let bookmarkFilledImage = UIImage(systemName: "bookmark.fill")

    var refreshUICallback: (() -> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImageView.layer.cornerRadius = 8
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        newsImageView.image = nil
        newsImageView.isHidden = false
        titleLabel.text = nil
        descriptionLabel.text = nil
        sourceLabel.text = nil
        authorLabel.text = nil
        dotLabel.isHidden = false
        saveButton.setImage(bookmarkImage, for: .normal)
    }

    @IBAction private func saveButtonPressed(_ sender: Any) {
        if viewModel.saved {
            viewModel.deleteArticle() { [weak self] success in
                guard success, let self = self else { return }
                self.saveButton.setImage(self.bookmarkImage, for: .normal)
                self.refreshUICallback?()
            }
        } else {
            viewModel.saveArticle() { [weak self] success in
                guard success, let self = self else { return }
                self.saveButton.setImage(self.bookmarkFilledImage, for: .normal)
                self.refreshUICallback?()
            }
        }
    }
    
    private func setupImage(withUrl url: String?) {
        guard let url = url else {
            newsImageView.isHidden = true
            return
        }
        viewModel.getImageData(url: url) { [weak self] data in
            guard let data = data, let image = UIImage(data: data, scale: 1) else {
                self?.newsImageView.isHidden = true
                return
            }
            DispatchQueue.main.async { [weak self] in
                self?.newsImageView.image = image
            }
        }
    }

    func configure(with viewModel: NewsItemViewModel) {
        self.viewModel = viewModel
        setupImage(withUrl: viewModel.article.urlToImage)
        titleLabel.text = viewModel.article.title
        descriptionLabel.text = viewModel.article.description
        sourceLabel.text = viewModel.article.source?.name
        authorLabel.text = viewModel.article.author
        if sourceLabel.text == nil || authorLabel.text == nil {
            dotLabel.isHidden = true
        }
        saveButton.setImage(viewModel.saved ? bookmarkFilledImage : bookmarkImage, for: .normal)
    }
}
