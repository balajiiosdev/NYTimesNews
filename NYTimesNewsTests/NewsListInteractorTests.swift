//
//  NewsListInteractorTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import XCTest
@testable import NYTimesNews
import NYTimesNewsApi

class NewsListInteractorTests: XCTestCase {
    var sut: NewsListInteractor!
    var newsApiService: MockNewsApiService!
    var presenter: MockNewsListPresenter!

    override func setUp() {
        super.setUp()
        newsApiService = MockNewsApiService()
        presenter = MockNewsListPresenter()
        sut = NewsListInteractor(newsApiService: newsApiService)
        sut.presenter = presenter
    }

    override func tearDown() {
        newsApiService = nil
        presenter = nil
        sut = nil
        super.tearDown()
    }

    func testFetchTopNews() {
        sut.fetchTopNews(request: NewsList.TopNews.Request(section: .home))

        XCTAssertEqual(newsApiService.fetchTopNewsCalledCount, 1)
        XCTAssertEqual(newsApiService.section, .home)
        XCTAssertEqual(sut.articles.count, 36)
        XCTAssertEqual(presenter.presentTopNewsCalledCount, 1)
        XCTAssertNotNil(presenter.topNewsResponse)
    }

    func testFetchTopNews_FailsWithRequestTimedOutError() {
        let topNewsError = NSError(domain: NSURLErrorDomain,
                                   code: NSURLErrorTimedOut,
                                   userInfo: nil)
        newsApiService.topNewsError = topNewsError

        sut.fetchTopNews(request: NewsList.TopNews.Request(section: .business))

        XCTAssertEqual(newsApiService.fetchTopNewsCalledCount, 1)
        XCTAssertEqual(newsApiService.section, .business)
        XCTAssertEqual(sut.articles.count, 0)
        XCTAssertEqual(presenter.presentErrorCalledCount, 1)
        XCTAssertNil(presenter.topNewsResponse)
        do {
            let presenterError = try XCTUnwrap(presenter.topNewsError) as NSError
            XCTAssertEqual(presenterError.code, topNewsError.code)
            XCTAssertEqual(presenterError.domain, topNewsError.domain)
        } catch let error {
            XCTFail("Test failed with \(error.localizedDescription)")
        }
    }

    func testFetchTopNews_FailsWithUnAuthorized() {
        newsApiService.topNewsError = HttpError.unauthorized

        sut.fetchTopNews(request: NewsList.TopNews.Request(section: .technology))

        XCTAssertEqual(newsApiService.fetchTopNewsCalledCount, 1)
        XCTAssertEqual(newsApiService.section, .technology)
        XCTAssertEqual(sut.articles.count, 0)
        XCTAssertEqual(presenter.presentErrorCalledCount, 1)
        XCTAssertNil(presenter.topNewsResponse)
        do {
            let presenterError = try XCTUnwrap(presenter.topNewsError as? HttpError)
            XCTAssertEqual(presenterError, HttpError.unauthorized)
        } catch let error {
            XCTFail("Test failed with \(error.localizedDescription)")
        }

    }
}
