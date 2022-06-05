//
//  NewsDetailsRouterTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import XCTest
@testable import NYTimesNews

class NewsDetailsRouterTests: XCTestCase {
    var sut: NewsDetailsRouter!
    var mockViewController: MockNewsDetailsViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewController = MockNewsDetailsViewController()
        sut = NewsDetailsRouter()
        sut.viewController = mockViewController
    }

    override func tearDownWithError() throws {
        sut = nil
        try super.tearDownWithError()
    }

    func testRouteToWebView() {
        let interactor = MockNewsDetailsInteractor()
        interactor.article = MockTopNewsResponseHelper.topNewsResponse()?.results[0]
        sut.dataStore = interactor

        sut.routeToWebView()

        XCTAssertEqual(mockViewController.presentViewControllerCalledCount, 1)
    }
}
