//
//  NewsListViewController.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit
import NYTimesNewsApi

protocol NewsListDisplayLogic: AnyObject {
    func displayTopNews(viewModel: NewsList.TopNews.ViewModel)
    func displayErrorAlert(title: String?, message: String?)
    func displayToast(message: String)
}

class NewsListViewController: UIViewController {
    var interactor: NewsListBusinessLogic?
    var router: (NSObjectProtocol & NewsListRoutingLogic & NewsListDataPassing)?

    // MARK: Initialisers
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    // MARK: Setup

    private func setup() {
        let viewController = self
        let configuration = Configuration(baseUrl: AppConstants.baseUrl, apiKey: AppConstants.apiKey)
        let newsApiService = NewsApiServiceProvider(configuration: configuration)
        let interactor = NewsListInteractor(newsApiService: newsApiService)
        let presenter = NewsListPresenter()
        let router = NewsListRouter()
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
        fetchTopNews()
    }

    // MARK: Top News

    func fetchTopNews(section: Section = .home) {
        let request = NewsList.TopNews.Request(section: section)
        interactor?.fetchTopNews(request: request)
    }
}

extension NewsListViewController: NewsListDisplayLogic {
    func displayTopNews(viewModel: NewsList.TopNews.ViewModel) {
    }

    func displayErrorAlert(title: String?, message: String?) {
    }

    func displayToast(message: String) {
    }
}
