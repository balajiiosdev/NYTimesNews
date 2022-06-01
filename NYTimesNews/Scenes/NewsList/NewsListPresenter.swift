//
//  NewsListPresenter.swift
//  NYTimesNews
//
//  Created by Balaji V on 5/31/22.
//

import UIKit

protocol NewsListPresentationLogic {
    func presentTopNews(response: NewsList.TopNews.Response)
    func presentError(error: Error)
}

class NewsListPresenter: NewsListPresentationLogic {
    weak var viewController: NewsListDisplayLogic?

    // MARK: Top News
    func presentTopNews(response: NewsList.TopNews.Response) {
    }

    func presentError(error: Error) {
    }
}
