//
//  NewsListInteractor.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit
import NYTimesNewsApi

protocol NewsListBusinessLogic {
    func fetchTopNews(request: NewsList.TopNews.Request)
}

protocol NewsListDataStore {
    var articles: [Article] { get }
}

class NewsListInteractor: NewsListBusinessLogic, NewsListDataStore {
    var presenter: NewsListPresentationLogic?
    private let newsApiService: NewsApiService
    var articles: [Article] = []

    init(newsApiService: NewsApiService) {
        self.newsApiService = newsApiService
    }

    // MARK: Top News

    func fetchTopNews(request: NewsList.TopNews.Request) {
        newsApiService.fetchTopNews(section: request.section) { [weak self] result in
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
