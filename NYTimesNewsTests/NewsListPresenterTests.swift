//
//  NewsListPresenterTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/1/22.
//

import XCTest
@testable import NYTimesNews
import NYTimesNewsApi

class NewsListPresenterTests: XCTestCase {
    var sut: NewsListPresenter!
    var mockViewController: MockNewsListViewController!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockViewController = MockNewsListViewController()
        sut = NewsListPresenter()
        sut.viewController = mockViewController
    }

    override func tearDownWithError() throws {
        mockViewController = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testPresentTopNews() {
        guard let response = topNewsResponse() else {
            XCTFail("Unable to prepare the TopNewsResponse object")
            return
        }

        sut.presentTopNews(response: NewsList.TopNews.Response(topNews: response))

        XCTAssertEqual(mockViewController.displayTopNewsCalledCount, 1)
        let viewModel = mockViewController.viewModel
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel?.articles.count, response.results.count)
    }

    func testPresentError_InternalServerError() {
        sut.presentError(error: HttpError.internalServerError)

        XCTAssertEqual(mockViewController.displayErrorAlertCalledCount, 1)
        XCTAssertEqual(mockViewController.alertTitle, NSLocalizedString("error_occured", comment: ""))
        XCTAssertEqual(mockViewController.alertMessage, NSLocalizedString("server_unavailable_message", comment: ""))
    }

    func testPresentError_NoDataFound() {
        sut.presentError(error: NetworkServiceError.noDataFound)

        XCTAssertEqual(mockViewController.displayErrorAlertCalledCount, 1)
        XCTAssertEqual(mockViewController.alertTitle, NSLocalizedString("error_occured", comment: ""))
        XCTAssertEqual(mockViewController.alertMessage, NSLocalizedString("something_went_wrong", comment: ""))
    }

    func testPresentError_RequestTimedOut() {
        let timedOutError = NSError(domain: NSURLErrorDomain, code: NSURLErrorTimedOut, userInfo: nil)
        sut.presentError(error: timedOutError)

        XCTAssertEqual(mockViewController.displayErrorAlertCalledCount, 1)
        XCTAssertEqual(mockViewController.alertTitle, NSLocalizedString("error_occured", comment: ""))
        XCTAssertEqual(mockViewController.alertMessage, NSLocalizedString("something_went_wrong", comment: ""))
    }

    func testPresentError_NoInternet() {
        let timedOutError = NSError(domain: NSURLErrorDomain, code: NSURLErrorNotConnectedToInternet, userInfo: nil)
        sut.presentError(error: timedOutError)

        XCTAssertEqual(mockViewController.displayErrorAlertCalledCount, 1)
        XCTAssertEqual(mockViewController.alertTitle, NSLocalizedString("no_internet_connection_title", comment: ""))
        let expectedMessage = NSLocalizedString("no_internet_connection_message", comment: "")
        XCTAssertEqual(mockViewController.alertMessage, expectedMessage)
    }

    private func topNewsResponse() -> TopNewsResponse? {
        guard let fileUrl = url(for: MockDataFileNames.topNewsValidResponse) else {
            XCTFail("\(MockDataFileNames.topNewsValidResponse) is not found")
            return nil
        }
        do {
            let data = try Data(contentsOf: fileUrl)
            let decoder = JSONDecoder()
            let response = try decoder.decode(TopNewsResponse.self, from: data)
            return response
        } catch {
            XCTFail("Failed to parse \(error.localizedDescription)")
            return nil
        }
    }

    private func url(for fileName: String) -> URL? {
        let bundle = Bundle(for: Self.self)
        guard let url = bundle.url(forResource: fileName,
                                   withExtension: nil) else {
            return nil
        }
        return url
    }
}
