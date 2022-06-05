//
//  MockNewsListPresenter.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import Foundation
@testable import NYTimesNews

class MockNewsListPresenter: NewsListPresentationLogic {
    var presentErrorCalledCount = 0
    var presentTopNewsCalledCount = 0
    var topNewsError: Error?
    var topNewsResponse: NewsList.TopNews.Response?

    func presentError(error: Error) {
        topNewsError = error
        presentErrorCalledCount += 1
    }

    func presentTopNews(response: NewsList.TopNews.Response) {
        topNewsResponse = response
        presentTopNewsCalledCount += 1
    }
}
