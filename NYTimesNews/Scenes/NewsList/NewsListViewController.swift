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
    var viewModel: NewsList.TopNews.ViewModel?
    var tableView: UITableView!
    let cellIdentifier = "newsCell"

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
        self.navigationItem.title = NSLocalizedString("top_news_title", comment: "")
        addTableView()
        fetchTopNews(section: .home)
    }

    private func addTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        view.addSubview(tableView)
        addConstraintsToTableView()
    }

    private func addConstraintsToTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    // MARK: Top News

    func fetchTopNews(section: Section) {
        let request = NewsList.TopNews.Request(section: section)
        interactor?.fetchTopNews(request: request)
    }
}

extension NewsListViewController: NewsListDisplayLogic {
    func displayTopNews(viewModel: NewsList.TopNews.ViewModel) {
        self.viewModel = viewModel
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayErrorAlert(title: String?, message: String?) {
    }

    func displayToast(message: String) {
    }
}

extension NewsListViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.articles.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        (cell as? NewsTableViewCell)?.article = viewModel?.articles[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}
