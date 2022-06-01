//
//  NewsListViewControllerTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import XCTest
@testable import NYTimesNews

class NewsListViewControllerTests: XCTestCase {
    var sut: NewsListViewController!
    var mockInteractor: MockNewsListInteractor!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as? NewsListViewController
        mockInteractor = MockNewsListInteractor()
        sut.interactor = mockInteractor
        XCTAssertNotNil(sut, "Sut is nil")
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testViewDidLoad() {
        sut.viewDidLoad()

        XCTAssertEqual(mockInteractor.fetchTopNewsCalledCount, 1)
    }
}
