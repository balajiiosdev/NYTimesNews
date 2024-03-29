//
//  NewsListViewController.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit
import NYTimesNewsApi
import MBProgressHUD

protocol NewsListDisplayLogic: AnyObject {
    func displayTopNews(viewModel: NewsList.TopNews.ViewModel)
    func displayErrorAlert(title: String?, message: String?)
}

class NewsListViewController: UIViewController {
    var interactor: NewsListBusinessLogic?
    var router: (NSObjectProtocol & NewsListRoutingLogic & NewsListDataPassing)?
    private var viewModel: NewsList.TopNews.ViewModel?
    var tableView: UITableView!
    private let cellIdentifier = "newsCell"
    private let refreshControl = UIRefreshControl()

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
        addPullToRefreshView()
        fetchTopNews(section: .home)
    }

    private func addTableView() {
        tableView = UITableView(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = 140
        view.addSubview(tableView)
        addConstraintsToTableView()
    }

    private  func addPullToRefreshView() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    private func addConstraintsToTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

    @objc private func refresh() {
        fetchTopNews(section: .home)
    }

    // MARK: Top News

    func fetchTopNews(section: Section) {
        if refreshControl.isRefreshing == false {
            showSpinner()
        }
        let request = NewsList.TopNews.Request(section: section)
        interactor?.fetchTopNews(request: request)
    }

    // MARK: Loading Progress

    private func showSpinner() {
        MBProgressHUD.showAdded(to: view, animated: true)
    }

    private func hideSpinner() {
        MBProgressHUD.hide(for: view, animated: true)
    }
}

extension NewsListViewController: NewsListDisplayLogic {
    func displayTopNews(viewModel: NewsList.TopNews.ViewModel) {
        self.viewModel = viewModel
        hideSpinner()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }

    func displayErrorAlert(title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okTitle = NSLocalizedString("alert_action_ok", comment: "")
        alert.addAction(UIAlertAction(title: okTitle, style: .cancel, handler: nil))
        present(alert, animated: true, completion: {[weak self] in
            if self?.refreshControl.isRefreshing == true {
                self?.refreshControl.endRefreshing()
            } else {
                self?.hideSpinner()
            }
        })
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
}

extension NewsListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToNewsDetailView(at: indexPath.row)
    }
}
