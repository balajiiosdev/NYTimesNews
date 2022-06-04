//
//  NewsTableViewCell.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/1/22.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.customFont(forTextStyle: .title3)
        label.textColor = UIColor.label
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    let authorLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.customFont(forTextStyle: .caption1)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textColor = .systemGray
        return label
    }()

    let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 7
        imageView.clipsToBounds = true
        return imageView
    }()

    var article: ArticleModel? {
        didSet {
            titleLabel.text = article?.title
            authorLabel.text = article?.author
            guard let url = article?.thumbnail?.url else { return }
            thumbnailImage.sd_setImage(with: url) { [weak self] image, _, _, _ in
                self?.thumbnailImage.image = image
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(thumbnailImage)
        setupUI()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupUI() {
        let topPadding = 10.0
        let imageWidth = 70.0
        let imageHeight = 70.0
        let imageTrailingSpace = -10.0
        let titleLeadingSpace = 10.0
        let titleTrailingSpace = -10.0
        let authorBottomSpace = -10.0
        let authorTopSpace = 10.0
        NSLayoutConstraint.activate([thumbnailImage.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
                                     thumbnailImage.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                                              constant: imageTrailingSpace),
                                     thumbnailImage.widthAnchor.constraint(equalToConstant: imageWidth),
                                     thumbnailImage.heightAnchor.constraint(equalToConstant: imageHeight)])
        NSLayoutConstraint.activate([titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: topPadding),
                                     titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor,
                                                                         constant: titleLeadingSpace),
                                     titleLabel.trailingAnchor.constraint(equalTo: thumbnailImage.leadingAnchor,
                                                                          constant: titleTrailingSpace)])
        NSLayoutConstraint.activate([authorLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor,
                                                                      constant: authorTopSpace),
                                     authorLabel.bottomAnchor.constraint(equalTo: bottomAnchor,
                                                                         constant: authorBottomSpace),
                                     authorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
                                     authorLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
                                    ])
    }
}
