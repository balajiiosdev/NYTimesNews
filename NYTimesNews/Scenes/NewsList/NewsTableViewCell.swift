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
        label.accessibilityLabel = "News Heading"
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
        label.accessibilityLabel = "Author"
        return label
    }()

    let thumbnailImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        imageView.accessibilityLabel = "Graphic"
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

    // MARK: Initialisers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        selectionStyle = .none
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    // MARK: UI Setup

    fileprivate func setupUI() {
        let padding = 10.0
        let horizontalStack = UIStackView()
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        horizontalStack.axis = .horizontal
        horizontalStack.layoutMargins = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        horizontalStack.isLayoutMarginsRelativeArrangement = true
        horizontalStack.alignment = .top
        addSubview(horizontalStack)
        NSLayoutConstraint.activate([
            horizontalStack.topAnchor.constraint(equalTo: topAnchor),
            horizontalStack.widthAnchor.constraint(equalTo: widthAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            horizontalStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: padding)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.spacing = 10.0
        addSubview(stackView)

        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)

        horizontalStack.addArrangedSubview(stackView)
        horizontalStack.addArrangedSubview(thumbnailImage)
        setupImageView()
    }

    func setupImageView() {
        let imageWidth = 100.0
        let imageHeight = 100.0
        NSLayoutConstraint.activate([
                                     thumbnailImage.widthAnchor.constraint(equalToConstant: imageWidth),
                                     thumbnailImage.heightAnchor.constraint(equalToConstant: imageHeight)])
    }

    // MARK: Accessbility

    override var accessibilityElements: [Any]? {
        get { [titleLabel as Any, authorLabel as Any, thumbnailImage as Any] }
        set {
            self.accessibilityElements = newValue
        }
    }
}
