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
    var mockTableView: MockTableView!
    var mockRouter: MockNewsListRouter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        sut = storyboard.instantiateViewController(withIdentifier: "NewsListViewController") as? NewsListViewController
        mockInteractor = MockNewsListInteractor()
        sut.interactor = mockInteractor
        mockTableView = MockTableView(frame: CGRect.zero, style: .plain)
        sut.tableView = mockTableView
        mockRouter = MockNewsListRouter()
        sut.router = mockRouter
        XCTAssertNotNil(sut, "Sut is nil")
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        mockTableView = nil
        mockRouter = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testViewDidLoad() {
        sut.loadViewIfNeeded()

        XCTAssertEqual(mockInteractor.fetchTopNewsCalledCount, 1)
    }

    func testDisplayTopNews() {
        let viewModel = NewsList.TopNews.ViewModel(articles: [], copyright: "NYTimes", lastUpdatedDate: "")
        sut.loadViewIfNeeded()
        sut.tableView = mockTableView

        sut.displayTopNews(viewModel: viewModel)

        XCTAssertEqual(mockTableView.reloadDataCalledCount, 1)
    }

    func testTableViewDidSelectRow() {
        sut.tableView(mockTableView, didSelectRowAt: IndexPath(row: 1, section: 0))

        XCTAssertEqual(mockRouter.routeToNewsDetailViewCalled, 1)
        XCTAssertEqual(mockRouter.index, 1)
    }
}
