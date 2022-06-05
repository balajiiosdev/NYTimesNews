//
//  NewsDetailViewController.swift
//  NYTimesNews
//
//  Created by Balaji V on 6/4/22.
//

import UIKit

protocol NewsDetailDisplayLogic: AnyObject {
    func displayNewsDetails(viewModel: NewsDetail.ViewModel)
}

class NewsDetailViewController: UIViewController {
    var interactor: NewsDetailBusinessLogic?
    var router: (NSObjectProtocol & NewsDetailsRoutingLogic & NewsDetailDataPassing)?
    let titleLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.customFont(forTextStyle: .title1)
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
        label.textColor = .systemGray2
        return label
    }()

    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        return imageView
    }()

    private let scrollView = UIScrollView()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let descriptionLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFont.customFont(forTextStyle: .subheadline)
        label.textColor = UIColor.label
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private let seeMoreButton: UIButton = {
        let button = UIButton(type: .roundedRect)
        let title = NSLocalizedString("see_more_button", comment: "")
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.customFont(forTextStyle: .subheadline)
        return button
    }()

    // MARK: Initialisers

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let interactor = NewsDetailsInteractor()
        let presenter = NewsDetailPresenter()
        let router = NewsDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }

    // MARK: View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = NSLocalizedString("news_details", comment: "")
        setupUI()
        fetchNewsDetails()
    }

    // MARK: UI Setup

    private func setupUI() {
        addScrollView()
        addStackView()
        addTitle()
        addAuthor()
        addImage()
        addDescription()
        addSeeMoreButton()
        let titleLabelBottomSpace = 10.0
        let authorLabelBottomSpace = 20.0
        let imageBottomSpace = 20.0
        stackView.setCustomSpacing(titleLabelBottomSpace, after: titleLabel)
        stackView.setCustomSpacing(authorLabelBottomSpace, after: authorLabel)
        stackView.setCustomSpacing(imageBottomSpace, after: imageView)
    }

    private func addStackView() {
        scrollView.addSubview(stackView)
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        ])
    }

    private func addTitle() {
        stackView.addArrangedSubview(titleLabel)
        titleLabel.accessibilityLabel = "Title"
    }

    private func addAuthor() {
        stackView.addArrangedSubview(authorLabel)
        authorLabel.accessibilityLabel = "Author"
    }

    private func addImage() {
        stackView.addArrangedSubview(imageView)
        imageView.accessibilityLabel = "Graphic"
        let imageHeight = 300.0
        let viewLayoutGuide = stackView.layoutMarginsGuide
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: viewLayoutGuide.widthAnchor),
            imageView.heightAnchor.constraint(equalToConstant: imageHeight)
        ])
    }

    private func addDescription() {
        stackView.addArrangedSubview(descriptionLabel)
        descriptionLabel.accessibilityLabel = "Description"
    }

    private func addSeeMoreButton() {
        seeMoreButton.accessibilityLabel = "See More"
        seeMoreButton.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(seeMoreButton)
        let seeMoreButtonTopSpace = 10.0
        NSLayoutConstraint.activate([
            seeMoreButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: seeMoreButtonTopSpace),
            seeMoreButton.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        ])
        seeMoreButton.addTarget(self, action: #selector(showMoreView), for: .touchUpInside)
    }

    @objc private func showMoreView() {
        router?.routeToWebView()
    }

    private func addScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        let viewLayoutGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: viewLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: viewLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: viewLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: viewLayoutGuide.trailingAnchor)
        ])
    }

    // MARK: Fetch News Details

    private func fetchNewsDetails() {
        let request = NewsDetail.Request()
        interactor?.fetchNewsDetails(request: request)
    }

    // MARK: Accessbility

    override var accessibilityElements: [Any]? {
        get { [titleLabel as Any, authorLabel as Any, imageView as Any,
               descriptionLabel as Any, seeMoreButton as Any] }
        set {
            self.accessibilityElements = newValue
        }
    }
}

extension NewsDetailViewController: NewsDetailDisplayLogic {
    func displayNewsDetails(viewModel: NewsDetail.ViewModel) {
        let details = viewModel.articleDetails
        titleLabel.text = details.title
        authorLabel.text = details.author
        descriptionLabel.text = details.description
        if let url = details.jumboImage?.url {
            imageView.sd_setImage(with: url) { [weak self] image, _, _, _ in
                // This completion block gets called on main thread.
                // Hence, no need to dispatch on main queue
                guard let self = self else { return }
                self.imageView.image = image
                self.updateScrollViewContentSize()
            }
        } else {
            NSLayoutConstraint.activate([
                imageView.heightAnchor.constraint(equalToConstant: 0)
            ])
            updateScrollViewContentSize()
        }
    }

    private func updateScrollViewContentSize() {
        var size = self.scrollView.contentSize
        size.height = self.seeMoreButton.frame.maxY + 10
        self.scrollView.contentSize = size
    }
}
