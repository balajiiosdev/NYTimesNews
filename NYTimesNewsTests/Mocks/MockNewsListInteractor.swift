//
//  MockNewsListInteractor.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import Foundation
@testable import NYTimesNews
import XCTest

class MockNewsListInteractor: NewsListBusinessLogic {
    var fetchTopNewsCalledCount = 0
    var request: NewsList.TopNews.Request?
    var expectation: XCTestExpectation?

    func fetchTopNews(request: NewsList.TopNews.Request) {
        fetchTopNewsCalledCount += 1
        self.request = request
        expectation?.fulfill()
    }
}
