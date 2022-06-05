//
//  NewsDetailsPresenterTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import XCTest
@testable import NYTimesNews

class NewsDetailsPresenterTests: XCTestCase {
    var sut: NewsDetailPresenter!
    var mockNewsDetailsView: MockNewsDetailsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        sut = NewsDetailPresenter()
        mockNewsDetailsView = MockNewsDetailsViewController()
        sut.viewController = mockNewsDetailsView
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testPresentNewsDetails() {
        guard let topNewsResponse = MockTopNewsResponseHelper.topNewsResponse() else {
            XCTFail("topNewsResponse is not available")
            return
        }
        let response = NewsDetail.Response(article: topNewsResponse.results[0])

        sut.presentNewsDetails(response: response)

        XCTAssertEqual(mockNewsDetailsView.displayNewsDetailsCalledCount, 1)
    }
}
