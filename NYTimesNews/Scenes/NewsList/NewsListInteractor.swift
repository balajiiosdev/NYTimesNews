//
//  NewsListInteractor.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit
import NYTimesNewsApi
import Reachability

protocol NewsListBusinessLogic {
    func fetchTopNews(request: NewsList.TopNews.Request)
}

protocol NewsListDataStore {
    var articles: [Article] { get }
}

class NewsListInteractor: NewsListBusinessLogic, NewsListDataStore {
    var presenter: NewsListPresentationLogic?
    private let newsApiService: NewsApiService
    private(set) var articles: [Article] = []
    var reachability: Reachable?
    private var request: NewsList.TopNews.Request?

    init(newsApiService: NewsApiService) {
        self.newsApiService = newsApiService
        reachability = try? Reachability()
        setupReachability()
    }

    deinit {
        reachability?.stopNotifier()
    }

    private func setupReachability() {
        reachability?.whenReachable = { [weak self] _ in
            NSLog("Reachable to internet")
            guard let previousRequest = self?.request else {
                return
            }
            self?.fetchTopNews(request: previousRequest)
        }
        reachability?.whenUnreachable = { _ in
            NSLog("Not reachable")
            // no-op
        }

        do {
            try reachability?.startNotifier()
        } catch {
            NSLog("could not start reachability notifier")
        }
    }

    // MARK: Top News

    func fetchTopNews(request: NewsList.TopNews.Request) {
        guard reachability?.connection != .unavailable else {
            self.request = request
            let error = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
            presenter?.presentError(error: error)
            return
        }
        newsApiService.fetchTopNews(section: request.section) { [weak self] result in
            self?.request = nil
            switch result {
            case .success(let response):
                let topNewsResponse = NewsList.TopNews.Response(topNews: response)
                self?.articles = response.results
                self?.presenter?.presentTopNews(response: topNewsResponse)
            case .failure(let error):
                self?.presenter?.presentError(error: error)
            }
        }
    }
}
