//
//  NewsDetailsViewControllerTests.swift
//  NYTimesNewsTests
//
//  Created by Balaji V on 6/5/22.
//

import XCTest
@testable import NYTimesNews

class NewsDetailsViewControllerTests: XCTestCase {

    var sut: NewsDetailViewController!
    var mockInteractor: MockNewsDetailsInteractor!
    var mockRouter: MockNewsDetailsRouter!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let bundle = Bundle.main
        let storyboard = UIStoryboard(name: "Main", bundle: bundle)
        let identifier = "NewsDetailViewController"
        sut = storyboard.instantiateViewController(withIdentifier: identifier) as? NewsDetailViewController
        mockInteractor = MockNewsDetailsInteractor()
        sut.interactor = mockInteractor
        mockRouter = MockNewsDetailsRouter()
        sut.router = mockRouter
        XCTAssertNotNil(sut, "Sut is nil")
    }

    override func tearDownWithError() throws {
        mockInteractor = nil
        mockRouter = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testDisplayNewsDetails() {
        let headline = "News Headline"
        let author = "Balaji V"
        let description = "This is description"
        let details = ArticleDetail(title: headline,
                                    author: author,
                                    description: description,
                                    jumboImage: nil)
        let viewModel = NewsDetail.ViewModel(articleDetails: details)

        sut.loadViewIfNeeded()
        sut.displayNewsDetails(viewModel: viewModel)

        XCTAssertEqual(sut.titleLabel.text, headline)
        XCTAssertEqual(sut.authorLabel.text, author)
        XCTAssertEqual(sut.descriptionLabel.text, description)
    }
}
