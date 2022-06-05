//
//  NewsApiServiceProviderTests.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 6/5/22.
//

import XCTest
@testable import NYTimesNewsApi

class NewsApiServiceProviderTests: XCTestCase {
    var sut: NewsApiServiceProvider!
    var mockNetworkService: MockNetworkService!
    var config: Configuration!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockNetworkService = MockNetworkService()
        config = Configuration(baseUrl: "test.nytimes.com",
                               apiKey: "123456")
        sut = NewsApiServiceProvider(configuration: config,
                                     networkService: mockNetworkService)
    }

    override func tearDownWithError() throws {
        mockNetworkService = nil
        sut = nil
        try super.tearDownWithError()
    }

    func testFetchTopNews() throws {
        sut.fetchTopNews(section: .home) { _ in
            // no-op
        }

        XCTAssertNotNil(mockNetworkService.topNewsRequest)
    }
}
