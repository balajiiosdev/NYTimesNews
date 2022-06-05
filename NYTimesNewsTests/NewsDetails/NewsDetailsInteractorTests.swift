//
//  NewsDetailsInteractorTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import XCTest
@testable import NYTimesNews

class NewsDetailsInteractorTests: XCTestCase {
    var sut: NewsDetailsInteractor!
    var mockPresenter: MockNewsDetailsPresenter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NewsDetailsInteractor()
        mockPresenter = MockNewsDetailsPresenter()
        sut.presenter = mockPresenter
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchNewsDetails() {
        let request = NewsDetail.Request()
        sut.article = MockTopNewsResponseHelper.topNewsResponse()?.results[0]

        sut.fetchNewsDetails(request: request)

        XCTAssertEqual(mockPresenter.presentNewsDetailsCalledCount, 1)
    }
}
