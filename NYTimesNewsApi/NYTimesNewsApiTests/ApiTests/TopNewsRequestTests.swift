//
//  TopNewsRequestTests.swift
//  NYTimesNewsApiTests
//
//  Created by Balaji V on 5/29/22.
//

import XCTest
@testable import NYTimesNewsApi

class TopNewsRequestTests: XCTestCase {
    var sut: TopNewsRequest!
    var configuration: Configuration!

    override func setUp() {
        super.setUp()
        configuration = Configuration(baseUrl: "https://test.api.nytimes.com", apiKey: "123456")
        sut = TopNewsRequest(configuration: configuration)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testHTTPMethod() {
        XCTAssertEqual(sut.method, HTTPMethod.get)
    }

    func testUrl() {
        let url = sut.url

        XCTAssertEqual(url, "\(configuration.baseUrl)/svc/topstories/v2/\(Section.home).json")
    }

    func testUrl_WithSectionTech() {
        sut = TopNewsRequest(configuration: configuration, section: Section.technology)

        XCTAssertEqual(sut.url, "\(configuration.baseUrl)/svc/topstories/v2/\(Section.technology).json")
    }

    func testHeaders() {
        XCTAssertTrue(sut.headers.isEmpty)
    }

    func testQueryParameters() {
        XCTAssertFalse(sut.queryItems.isEmpty)
        XCTAssertEqual(sut.queryItems.count, 1)
        XCTAssertNotNil(sut.queryItems[QueryParameters.apiKey])
    }

    func testDecode() throws {
        let url = try XCTUnwrap(url(for: MockDataFileNames.topNewsValidResponse))
        let data = try Data(contentsOf: url)
        let response = try sut.decode(data)

        XCTAssertEqual(response.status, "OK")
        XCTAssertEqual(response.numOfResults, 36)
        XCTAssertEqual(response.results.count, 36)
    }

    func testDecode_WithErrorResponse() {
        do {
            let url = try XCTUnwrap(url(for: MockDataFileNames.errorResponse))
            let data = try Data(contentsOf: url)

            _ = try sut.decode(data)
            XCTFail("Error is exptected")
        } catch let error {
            XCTAssertTrue(error is DecodingError)
        }
    }
}
